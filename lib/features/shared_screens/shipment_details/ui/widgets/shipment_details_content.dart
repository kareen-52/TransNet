import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ShipmentDetailsContent
// شاشة تفاصيل الشحنة — جانب العميل
//
// الترتيب حسب الأولوية:
//  1. Header  (رقم الشحنة + الحالة + التتبع الحي)
//  2. QR Code (تأكيد الاستلام عند نقطة البداية)
//  3. PIN     (تأكيد التسليم عند نقطة الوصول)
//  4. المسار  (من → إلى)
//  5. تفاصيل الشحنة (السعر، الوزن، الأبعاد، النوع)
//  6. حالة الشحنة (التواريخ، الدفع، الإتمام)
//  7. الأطراف (السائق / العميل)
// ─────────────────────────────────────────────────────────────────────────────

class ShipmentDetailsContent extends StatelessWidget {
  final ShipmentDetailsResponse data;
  final int shipmentId;

  const ShipmentDetailsContent({
    super.key,
    required this.data,
    required this.shipmentId,
  });

  @override
  Widget build(BuildContext context) {
    final s = data.shipment;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCompleted = s.success == 1;
    final isActive = s.status == 'جارية' || s.status == 'قيد التوصيل';

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _AppBar(shipment: s, isDark: isDark, isCompleted: isCompleted),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 48.h),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 16.h),

              // ── 1. Header Card ────────────────────────────────────────────
              _ShipmentHeaderCard(shipment: s, isDark: isDark),
              SizedBox(height: 16.h),

              // ── 2. Live Tracking (إذا كان النشاط جارياً) ─────────────────
              if (isActive && data.live_tracking != null) ...[
                _LiveTrackingBanner(liveTracking: data.live_tracking, isDark: isDark),
                SizedBox(height: 16.h),
              ],

              // ── 3. QR Code Section (تأكيد الاستلام) ──────────────────────
              // يظهر فقط إذا كانت الحالة "جارية" أو كان qr_pin موجوداً
              if (s.qrPin != null) ...[
                _SectionLabel(
                  label: 'رمز QR — تأكيد استلام الشحنة',
                  icon: Icons.qr_code_2_rounded,
                  color: AppColors.primary,
                ),
                SizedBox(height: 8.h),
                _QrCodeSection(qrPin: s.qrPin!, isDark: isDark, status: s.status),
                SizedBox(height: 16.h),
              ],

              // ── 4. PIN Section (تأكيد التسليم) ───────────────────────────
              // يظهر دائماً إذا كان الـ PIN موجوداً
              if (s.pin != null) ...[
                _SectionLabel(
                  label: 'رمز PIN — تأكيد التوصيل',
                  icon: Icons.pin_outlined,
                  color: const Color(0xFF7C3AED),
                ),
                SizedBox(height: 8.h),
                _PinSection(pin: s.pin!, isDark: isDark, status: s.status),
                SizedBox(height: 16.h),
              ],

              // ── 5. Route ──────────────────────────────────────────────────
              _SectionLabel(
                label: 'مسار الشحنة',
                icon: Icons.route_rounded,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              _RouteCard(
                start: s.startGovernorate,
                end: s.endGovernorate,
                isDark: isDark,
              ),
              SizedBox(height: 16.h),

              // ── 6. Shipment Details ───────────────────────────────────────
              _SectionLabel(
                label: 'تفاصيل الشحنة',
                icon: Icons.inventory_2_outlined,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              _ShipmentDetailsCard(shipment: s, isDark: isDark),
              SizedBox(height: 16.h),

              // ── 7. Status ─────────────────────────────────────────────────
              _SectionLabel(
                label: 'معلومات إضافية',
                icon: Icons.info_outline_rounded,
                color: AppColors.primary,
              ),
              SizedBox(height: 8.h),
              _StatusCard(shipment: s, isDark: isDark),
              SizedBox(height: 16.h),

              // ── 8. Parties ────────────────────────────────────────────────
              if (data.driver != null || data.client != null) ...[
                _SectionLabel(
                  label: 'الأطراف',
                  icon: Icons.people_outline_rounded,
                  color: AppColors.primary,
                ),
                SizedBox(height: 8.h),
                if (data.driver != null) ...[
                  _PartyCard(
                    party: data.driver!,
                    role: 'السائق',
                    isDark: isDark,
                    icon: Icons.drive_eta_outlined,
                    iconColor: AppColors.primary,
                  ),
                  SizedBox(height: 8.h),
                ],
                if (data.client != null)
                  _PartyCard(
                    party: data.client!,
                    role: 'العميل',
                    isDark: isDark,
                    icon: Icons.person_outline_rounded,
                    iconColor: AppColors.secondary,
                  ),
              ],
            ]),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _AppBar
// ─────────────────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;
  final bool isCompleted;

  const _AppBar({
    required this.shipment,
    required this.isDark,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(shipment.status, isCompleted);

    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: Colors.black.withOpacity(0.08),
      leading: Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: _GlassIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          isDark: isDark,
          onTap: () => Navigator.pop(context),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل الشحنة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
          ),
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                shipment.status ?? (isCompleted ? 'مكتملة' : 'قيد التنفيذ'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ShipmentHeaderCard
// ─────────────────────────────────────────────────────────────────────────────

class _ShipmentHeaderCard extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _ShipmentHeaderCard({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isCompleted = shipment.success == 1;
    final statusColor = _statusColor(shipment.status, isCompleted);
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(surface, border, isDark),
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.local_shipping_rounded,
              color: statusColor,
              size: 26.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'شحنة #${shipment.shipmentNumber}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    CopyButton(
                      value: shipment.shipmentNumber.toString(),
                      label: 'نسخ',
                      isDark: isDark,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                _StatusPill(
                  label: shipment.status ?? (isCompleted ? 'مكتملة' : 'قيد التنفيذ'),
                  color: statusColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _LiveTrackingBanner — وقت وصول تقديري
// ─────────────────────────────────────────────────────────────────────────────

class _LiveTrackingBanner extends StatelessWidget {
  final dynamic liveTracking;
  final bool isDark;

  const _LiveTrackingBanner({required this.liveTracking, required this.isDark});

  @override
  Widget build(BuildContext context) {
    // liveTracking: { remaining_distance_km, remaining_duration_mins }
    final distanceKm = (liveTracking['remaining_distance_km'] as num?)?.toDouble();
    final durationMins = (liveTracking['remaining_duration_mins'] as num?)?.toInt();

    if (distanceKm == null && durationMins == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.9),
            AppColors.primaryDark.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // أيقونة التتبع الحي
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.navigation_rounded, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),

          // التفاصيل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'السائق في الطريق',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  durationMins != null
                      ? 'الوصول خلال ~$durationMins دقيقة'
                      : 'جاري التتبع...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // المسافة المتبقية
          if (distanceKm != null)
            Column(
              children: [
                Text(
                  '$distanceKm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'كم',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _QrCodeSection
// يعرض الـ QR مع شرح واضح لماذا يحتاجه العميل
// ─────────────────────────────────────────────────────────────────────────────

class _QrCodeSection extends StatelessWidget {
  final String qrPin;
  final bool isDark;
  final String? status;

  const _QrCodeSection({
    required this.qrPin,
    required this.isDark,
    required this.status,
  });

  // هل تم مسح QR بنجاح (الحالة تغيرت لـ قيد التوصيل)
  bool get _isScanned => status == 'قيد التوصيل' || status == 'مستلمة';

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return Container(
      decoration: _cardDecoration(surface, border, isDark),
      child: Column(
        children: [
          // ── شرح القسم ──────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _isScanned
                  ? AppColors.success.withOpacity(0.08)
                  : AppColors.primary.withOpacity(0.06),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // أيقونة الحالة
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _isScanned
                        ? AppColors.success.withOpacity(0.12)
                        : AppColors.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isScanned
                        ? Icons.check_circle_rounded
                        : Icons.qr_code_scanner_rounded,
                    color: _isScanned ? AppColors.success : AppColors.primary,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),

                // النص التوضيحي
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isScanned ? 'تم تأكيد الاستلام ✓' : 'رمز استلام الشحنة',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: _isScanned ? AppColors.success : AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _isScanned
                            ? 'قام السائق بمسح هذا الرمز وتم تأكيد استلام الشحنة. الشحنة الآن في طريقها إليك.'
                            : 'عندما يصل السائق لاستلام شحنتك، اعرض له هذا الرمز ليقوم بمسحه وتأكيد الاستلام.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          height: 1.5,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── QR Code ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // رمز QR
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // QR widget
                    ColorFiltered(
                      colorFilter: _isScanned
                          ? const ColorFilter.matrix([
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0,      0,      0,      1, 0,
                            ])
                          : const ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.color,
                            ),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: QrImageView(
                          data: qrPin,
                          version: QrVersions.auto,
                          size: 180.w,
                          backgroundColor: Colors.white,
                          eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: _isScanned ? Colors.grey : Colors.black,
                          ),
                          dataModuleStyle: QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: _isScanned ? Colors.grey : Colors.black,
                          ),
                        ),
                      ),
                    ),

                    // Overlay عند الاكتمال
                    if (_isScanned)
                      Container(
                        width: 180.w,
                        height: 180.w,
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.success,
                              size: 48.sp,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'تم الاستلام',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 12.h),

                // تعليمة تحت الـ QR
                if (!_isScanned)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'اعرض هذا الرمز للسائق فقط',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _PinSection
// يعرض الـ PIN مع شرح واضح لماذا يحتاجه العميل
// ─────────────────────────────────────────────────────────────────────────────

class _PinSection extends StatefulWidget {
  final String pin;
  final bool isDark;
  final String? status;

  const _PinSection({
    required this.pin,
    required this.isDark,
    required this.status,
  });

  @override
  State<_PinSection> createState() => _PinSectionState();
}

class _PinSectionState extends State<_PinSection> {
  bool _hidden = true;

  bool get _isDelivered => widget.status == 'مستلمة';

  @override
  Widget build(BuildContext context) {
    final surface = widget.isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = widget.isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final subText = widget.isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;
    final pinColor = const Color(0xFF7C3AED); // بنفسجي مميز لـ PIN

    return Container(
      decoration: _cardDecoration(surface, border, widget.isDark),
      child: Column(
        children: [
          // ── شرح القسم ──────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _isDelivered
                  ? AppColors.success.withOpacity(0.08)
                  : pinColor.withOpacity(0.06),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // أيقونة
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _isDelivered
                        ? AppColors.success.withOpacity(0.12)
                        : pinColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isDelivered
                        ? Icons.check_circle_rounded
                        : Icons.pin_outlined,
                    color: _isDelivered ? AppColors.success : pinColor,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),

                // النص التوضيحي
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isDelivered ? 'تم التسليم بنجاح ✓' : 'رمز تأكيد التوصيل',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: _isDelivered ? AppColors.success : pinColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _isDelivered
                            ? 'تم إدخال رمز التأكيد بنجاح وتأكيد توصيل الشحنة.'
                            : 'عندما يصل السائق بشحنتك، أعطه هذا الرمز المكون من 6 أرقام لتأكيد التسليم وإتمام عملية التوصيل.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          height: 1.5,
                          color: subText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── الـ PIN ────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                // ─── الأرقام الـ 6 ──────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.pin.length.clamp(0, 6), (i) {
                    return _PinDigitBox(
                      digit: widget.pin[i],
                      hidden: _hidden,
                      isDark: widget.isDark,
                      isDelivered: _isDelivered,
                      pinColor: pinColor,
                    );
                  }),
                ),
                SizedBox(height: 16.h),

                // ─── أزرار: إظهار + نسخ ─────────────────────────────────
                Row(
                  children: [
                    // زر إظهار/إخفاء
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _hidden = !_hidden),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: widget.isDark
                                ? Colors.white.withOpacity(0.06)
                                : Colors.black.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: widget.isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.08),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _hidden
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 16.sp,
                                color: subText,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                _hidden ? 'إظهار الرمز' : 'إخفاء الرمز',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: subText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // زر النسخ
                    Expanded(
                      child: CopyButton(
                        value: widget.pin,
                        label: 'نسخ الرمز',
                        isDark: widget.isDark,
                        filled: true,
                        fillColor: pinColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // ─── تحذير ─────────────────────────────────────────────
                if (!_isDelivered)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.warning.withOpacity(0.25),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 15.sp,
                          color: AppColors.warning,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'لا تشارك هذا الرمز إلا عند استلام شحنتك يدوياً من السائق',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.warning,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _PinDigitBox — صندوق رقم واحد من الـ PIN
// ─────────────────────────────────────────────────────────────────────────────

class _PinDigitBox extends StatelessWidget {
  final String digit;
  final bool hidden;
  final bool isDark;
  final bool isDelivered;
  final Color pinColor;

  const _PinDigitBox({
    required this.digit,
    required this.hidden,
    required this.isDark,
    required this.isDelivered,
    required this.pinColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDelivered
        ? AppColors.success.withOpacity(0.1)
        : pinColor.withOpacity(0.08);
    final borderColor = isDelivered
        ? AppColors.success.withOpacity(0.3)
        : pinColor.withOpacity(0.25);
    final textColor = isDelivered ? AppColors.success : pinColor;

    return Container(
      width: 44.w,
      height: 52.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            hidden ? '•' : digit,
            key: ValueKey(hidden),
            style: TextStyle(
              fontSize: hidden ? 24.sp : 22.sp,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: hidden ? 0 : 2,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SectionLabel
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _SectionLabel({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: color),
        SizedBox(width: 6.w),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _RouteCard
// ─────────────────────────────────────────────────────────────────────────────

class _RouteCard extends StatelessWidget {
  final String start, end;
  final bool isDark;

  const _RouteCard({required this.start, required this.end, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final subText = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(surface, border, isDark),
      child: Row(
        children: [
          // نقطة البداية
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.w, height: 8.w,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.success.withOpacity(0.35),
                          width: 2.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text('الانطلاق',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: subText,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(start,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),

          // فاصل
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (i) => Container(
                      width: 4.w, height: 2.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: subText.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(1.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Icon(Icons.arrow_forward_rounded, size: 16.sp, color: subText),
              ],
            ),
          ),

          // نقطة الوصول
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('الوجهة',
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: subText,
                            fontWeight: FontWeight.w500)),
                    SizedBox(width: 6.w),
                    Container(
                      width: 8.w, height: 8.w,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.error.withOpacity(0.35),
                          width: 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(end,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ShipmentDetailsCard
// ─────────────────────────────────────────────────────────────────────────────

class _ShipmentDetailsCard extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _ShipmentDetailsCard({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final hasDims = shipment.width != null ||
        shipment.height != null ||
        shipment.length != null;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price banner
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'السعر الإجمالي',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        '${shipment.price ?? 0} ل.س',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                if (shipment.insurance != null && shipment.insurance! > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.security_rounded, color: Colors.white, size: 16.sp),
                        SizedBox(height: 3.h),
                        Text('تأمين',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                if (shipment.object != null) ...[
                  _InfoRow(
                    icon: Icons.inventory_2_outlined,
                    label: 'نوع المحمول',
                    value: shipment.object!,
                    isDark: isDark,
                  ),
                  _RowDivider(isDark: isDark),
                ],
                if (shipment.weight != null) ...[
                  _InfoRow(
                    icon: Icons.scale_outlined,
                    label: 'الوزن',
                    value: '${shipment.weight} كغم',
                    isDark: isDark,
                  ),
                  if (hasDims) _RowDivider(isDark: isDark),
                ],
                if (hasDims) _DimensionsRow(shipment: shipment, isDark: isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _StatusCard
// ─────────────────────────────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _StatusCard({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final isPaid = shipment.paid == 1;
    final isCompleted = shipment.success == 1;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(surface, border, isDark),
      child: Column(
        children: [
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'موعد التسليم',
            value: _formatDate(shipment.deliveryDeadline),
            isDark: isDark,
          ),
          _RowDivider(isDark: isDark),
          _InfoRow(
            icon: Icons.calendar_month_outlined,
            label: 'تاريخ الإنشاء',
            value: _formatDate(shipment.createdAt),
            isDark: isDark,
          ),
          _RowDivider(isDark: isDark),
          Row(
            children: [
              Expanded(
                child: _StatusBadge(
                  icon: Icons.payments_outlined,
                  label: isPaid ? 'مدفوع' : 'غير مدفوع',
                  color: isPaid ? AppColors.success : AppColors.warning,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _StatusBadge(
                  icon: Icons.check_circle_outline_rounded,
                  label: isCompleted ? 'مكتملة' : 'قيد التنفيذ',
                  color: isCompleted ? AppColors.success : AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String? raw) {
    if (raw == null) return 'غير محدد';
    try {
      final parts = raw.split(' ');
      if (parts.length >= 2) {
        final d = parts[0].split('-').reversed.join('/');
        final t = parts[1].substring(0, 5);
        return '$d  $t';
      }
    } catch (_) {}
    return raw;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _PartyCard
// ─────────────────────────────────────────────────────────────────────────────

class _PartyCard extends StatelessWidget {
  final PartyInfo party;
  final String role;
  final bool isDark;
  final IconData icon;
  final Color iconColor;

  const _PartyCard({
    required this.party,
    required this.role,
    required this.isDark,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final subColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(surface, border, isDark),
      child: Row(
        children: [
          Container(
            width: 46.w, height: 46.w,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: TextStyle(
                        fontSize: 11.sp, color: subColor, fontWeight: FontWeight.w500)),
                SizedBox(height: 2.h),
                Text('${party.firstName} ${party.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                SizedBox(height: 2.h),
                Text(party.phoneNumber,
                    style: TextStyle(fontSize: 12.sp, color: subColor, letterSpacing: 0.5)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => HapticFeedback.lightImpact(),
            child: Container(
              width: 38.w, height: 38.w,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.call_outlined, color: iconColor, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared widgets
// ─────────────────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final bool isDark;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final subColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Row(
      children: [
        Container(
          width: 34.w, height: 34.w,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Icon(icon, size: 16.sp, color: subColor),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Text(label, style: TextStyle(fontSize: 13.sp, color: subColor))),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _RowDivider extends StatelessWidget {
  final bool isDark;
  const _RowDivider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 18.h,
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    );
  }
}

class _DimensionsRow extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _DimensionsRow({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final subColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 34.w, height: 34.w,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.06)
                    : Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(Icons.straighten_rounded, size: 16.sp, color: subColor),
            ),
            SizedBox(width: 12.w),
            Text('الأبعاد', style: TextStyle(fontSize: 13.sp, color: subColor)),
          ],
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 6.h,
          children: [
            if (shipment.width != null)
              _DimChip(label: 'عرض', value: '${shipment.width} سم', isDark: isDark),
            if (shipment.height != null)
              _DimChip(label: 'ارتفاع', value: '${shipment.height} سم', isDark: isDark),
            if (shipment.length != null)
              _DimChip(label: 'طول', value: '${shipment.length} سم', isDark: isDark),
          ],
        ),
      ],
    );
  }
}

class _DimChip extends StatelessWidget {
  final String label, value;
  final bool isDark;

  const _DimChip({required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withOpacity(0.12)
            : AppColors.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '$label  ',
            style: TextStyle(
              fontSize: 10.sp,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ]),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatusBadge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                  color: color, fontSize: 12.sp, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback? onTap;

  const _GlassIconButton({required this.icon, required this.isDark, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38.w, height: 38.w,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.06),
          ),
        ),
        child: Icon(icon, size: 18.sp,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CopyButton (reusable, exported)
// ─────────────────────────────────────────────────────────────────────────────

class CopyButton extends StatefulWidget {
  final String value;
  final String label;
  final bool isDark;
  final bool filled;
  final Color? fillColor;

  const CopyButton({
    super.key,
    required this.value,
    required this.label,
    required this.isDark,
    this.filled = false,
    this.fillColor,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> with SingleTickerProviderStateMixin {
  bool _copied = false;
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    _scale = Tween(begin: 1.0, end: 0.88)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _copy() async {
    await _ctrl.forward();
    await _ctrl.reverse();
    await Clipboard.setData(ClipboardData(text: widget.value));
    HapticFeedback.lightImpact();
    if (mounted) setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.fillColor ?? AppColors.primary;

    if (widget.filled) {
      return ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTap: _copy,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: _copied ? AppColors.success : activeColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _copied ? Icons.check_rounded : Icons.copy_rounded,
                  size: 14.sp,
                  color: Colors.white,
                ),
                SizedBox(width: 6.w),
                Text(
                  _copied ? 'تم النسخ ✓' : widget.label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: _copy,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: _copied
                ? AppColors.success.withOpacity(0.12)
                : (widget.isDark
                    ? Colors.white.withOpacity(0.07)
                    : activeColor.withOpacity(0.07)),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: _copied
                  ? AppColors.success.withOpacity(0.4)
                  : (widget.isDark
                      ? Colors.white.withOpacity(0.12)
                      : activeColor.withOpacity(0.2)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _copied ? Icons.check_rounded : Icons.copy_rounded,
                size: 12.sp,
                color: _copied ? AppColors.success : activeColor,
              ),
              SizedBox(width: 4.w),
              Text(
                _copied ? 'تم!' : widget.label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: _copied ? AppColors.success : activeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

Color _statusColor(String? status, bool isCompleted) {
  if (isCompleted || status == 'مستلمة') return AppColors.success;
  switch (status) {
    case 'جارية':
      return AppColors.primary;
    case 'قيد التوصيل':
      return const Color(0xFF7C3AED);
    default:
      return AppColors.secondary;
  }
}

BoxDecoration _cardDecoration(Color surface, Color border, bool isDark) {
  return BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ],
  );
}