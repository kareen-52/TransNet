import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';

// ─── Main Content ─────────────────────────────────────────────────────────────

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

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _AppBar(shipment: s, isDark: isDark, isCompleted: isCompleted, data: data),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 40.h),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 16.h),

              // ── Header: shipment number + status
              _ShipmentHeaderCard(shipment: s, isDark: isDark),
              SizedBox(height: 12.h),

              // ── PIN + QR (if available)
              if (s.pin != null || s.qrPin != null) ...[
                _PinQrRow(pin: s.pin, qrPin: s.qrPin, isDark: isDark),
                SizedBox(height: 12.h),
              ],

              // ── Route (from → to)
              _SectionLabel(label: 'مسار الشحنة', icon: Icons.route_rounded),
              SizedBox(height: 8.h),
              _RouteCard(
                start: s.startGovernorate,
                end: s.endGovernorate,
                isDark: isDark,
              ),
              SizedBox(height: 12.h),

              // ── Map preview card (tappable → full-screen)
              _SectionLabel(label: 'الخريطة', icon: Icons.map_rounded),
              SizedBox(height: 8.h),
              // ShipmentMapCard(
              //   geometry: data.route_geometry,
              //   startLat: s.startPositionLat,
              //   startLng: s.startPositionLng,
              //   endLat: s.endPositionLat,
              //   endLng: s.endPositionLng,
              //   isDark: isDark,
              // ),
              SizedBox(height: 12.h),

              // ── Shipment details (price, weight, dims, object)
              _SectionLabel(label: 'تفاصيل الشحنة', icon: Icons.inventory_2_outlined),
              SizedBox(height: 8.h),
              _ShipmentDetailsCard(shipment: s, isDark: isDark),
              SizedBox(height: 12.h),

              // ── Status card (dates, payment, completion)
              _SectionLabel(label: 'حالة الشحنة', icon: Icons.info_outline_rounded),
              SizedBox(height: 8.h),
              _StatusCard(shipment: s, isDark: isDark),
              SizedBox(height: 12.h),

              // ── Driver / Client
              if (data.driver != null || data.client != null) ...[
                _SectionLabel(label: 'الأطراف', icon: Icons.people_outline_rounded),
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

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  final ShipmentDetail shipment;
  final ShipmentDetailsResponse data;
  final bool isDark, isCompleted;

  const _AppBar({
    required this.shipment,
    required this.data,
    required this.isDark,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isCompleted ? AppColors.success : AppColors.secondary;

    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      snap: true,
      pinned: true,
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
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
                decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
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
      actions: [
        _GlassIconButton(
          icon: Icons.share_rounded,
          isDark: isDark,
          // onTap: () => ShipmentShareService.shareShipmentDetails(
          //   context: context,
          //   shipment: shipment,
          //   driver: data.driver,
          //   client: data.client,
          // ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}

// ─── Glass Icon Button ────────────────────────────────────────────────────────

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
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        child: Icon(icon,
            size: 18.sp,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SectionLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.primary),
        SizedBox(width: 6.w),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
        ),
      ],
    );
  }
}

// ─── Shipment Header Card ─────────────────────────────────────────────────────

class _ShipmentHeaderCard extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _ShipmentHeaderCard({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isCompleted = shipment.success == 1;
    final statusColor = isCompleted ? AppColors.success : AppColors.secondary;
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
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(Icons.local_shipping_rounded,
                color: statusColor, size: 26.sp),
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    CopyButton(
                      value: shipment.shipmentNumber.toString(),
                      label: 'نسخ الرقم',
                      isDark: isDark,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                _StatusPill(
                  label: shipment.status ??
                      (isCompleted ? 'مكتملة' : 'قيد التنفيذ'),
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

// ─── Status Pill ─────────────────────────────────────────────────────────────

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─── Copy Button (reusable, exported) ─────────────────────────────────────────

class CopyButton extends StatefulWidget {
  final String value;
  final String label;
  final bool isDark;
  final bool filled;

  const CopyButton({
    super.key,
    required this.value,
    required this.label,
    required this.isDark,
    this.filled = false,
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton>
    with SingleTickerProviderStateMixin {
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
    final isCopied = _copied;

    if (widget.filled) {
      return ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTap: _copy,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: isCopied ? AppColors.success : AppColors.primary,
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isCopied ? Icons.check_rounded : Icons.copy_rounded,
                  size: 14.sp,
                  color: Colors.white,
                ),
                SizedBox(width: 6.w),
                Text(
                  isCopied ? 'تم النسخ ✓' : widget.label,
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
            color: isCopied
                ? AppColors.success.withValues(alpha: 0.12)
                : (widget.isDark
                    ? Colors.white.withValues(alpha: 0.07)
                    : AppColors.primary.withValues(alpha: 0.07)),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isCopied
                  ? AppColors.success.withValues(alpha: 0.4)
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : AppColors.primary.withValues(alpha: 0.2)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCopied ? Icons.check_rounded : Icons.copy_rounded,
                size: 12.sp,
                color: isCopied ? AppColors.success : AppColors.primary,
              ),
              SizedBox(width: 4.w),
              Text(
                isCopied ? 'تم!' : widget.label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: isCopied ? AppColors.success : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── PIN + QR Row ─────────────────────────────────────────────────────────────

class _PinQrRow extends StatelessWidget {
  final String? pin;
  final String? qrPin;
  final bool isDark;

  const _PinQrRow({this.pin, this.qrPin, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (pin != null)
            Expanded(child: _PinCard(pin: pin!, isDark: isDark)),
          if (pin != null && qrPin != null) SizedBox(width: 10.w),
          if (qrPin != null)
            _QrTile(qrPin: qrPin!, isDark: isDark),
        ],
      ),
    );
  }
}

// ─── PIN Card ─────────────────────────────────────────────────────────────────

class _PinCard extends StatefulWidget {
  final String pin;
  final bool isDark;

  const _PinCard({required this.pin, required this.isDark});

  @override
  State<_PinCard> createState() => _PinCardState();
}

class _PinCardState extends State<_PinCard> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    final surface = widget.isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = widget.isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondaryText = widget.isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: _cardDecoration(surface, border, widget.isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label row
          Row(
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.pin_outlined, size: 16.sp, color: AppColors.primary),
              ),
              SizedBox(width: 8.w),
              Text(
                'رمز PIN',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // PIN value + visibility toggle
          Row(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _hidden ? '• ' * widget.pin.length.clamp(0, 6) : widget.pin,
                    key: ValueKey(_hidden),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _hidden = !_hidden),
                child: Icon(
                  _hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  size: 18.sp,
                  color: secondaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Full-width copy button
          CopyButton(
            value: widget.pin,
            label: 'نسخ الـ PIN',
            isDark: widget.isDark,
            filled: true,
          ),
        ],
      ),
    );
  }
}

// ─── QR Tile ──────────────────────────────────────────────────────────────────

class _QrTile extends StatelessWidget {
  final String qrPin;
  final bool isDark;

  const _QrTile({required this.qrPin, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        // Navigator.push(
        //   context,
        //   // PageRouteBuilder(
        //   //   pageBuilder: (_, __, ___) => QrFullScreen(qrPin: qrPin),
        //   //   transitionsBuilder: (_, anim, __, child) => FadeTransition(
        //   //     opacity: anim,
        //   //     child: child,
        //   //   ),
        //   //   transitionDuration: const Duration(milliseconds: 280),
        //   // ),
        // );
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primary.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Icon(Icons.qr_code_2_rounded,
                  size: 26.sp, color: AppColors.primary),
            ),
            SizedBox(height: 10.h),
            Text(
              'QR كود',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            Text(
              'اضغط للفتح',
              style: TextStyle(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Route Card ───────────────────────────────────────────────────────────────

class _RouteCard extends StatelessWidget {
  final String start, end;
  final bool isDark;

  const _RouteCard({required this.start, required this.end, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final subText =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(surface, border, isDark),
      child: Row(
        children: [
          // Origin
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _LocationDot(color: AppColors.success),
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

          // Dashed divider + arrow
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (i) => Container(
                      width: 4.w,
                      height: 2.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: subText.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(1.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Icon(Icons.arrow_forward_rounded,
                    size: 16.sp, color: subText),
              ],
            ),
          ),

          // Destination
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
                    _LocationDot(color: AppColors.error),
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

class _LocationDot extends StatelessWidget {
  final Color color;
  const _LocationDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.35), width: 2.5),
      ),
    );
  }
}

// ─── Shipment Details Card ────────────────────────────────────────────────────

class _ShipmentDetailsCard extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _ShipmentDetailsCard({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final hasDims =
        shipment.width != null || shipment.height != null || shipment.length != null;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Price hero banner
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
                          color: Colors.white.withValues(alpha: 0.75),
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
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.security_rounded,
                            color: Colors.white, size: 16.sp),
                        SizedBox(height: 3.h),
                        Text('${shipment.insurance} ل.س',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700)),
                        Text('تأمين',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 9.sp)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Detail rows
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

// ─── Info Row ─────────────────────────────────────────────────────────────────

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
    final subColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Row(
      children: [
        Container(
          width: 34.w,
          height: 34.w,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.06)
                : Colors.black.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: Icon(icon, size: 16.sp, color: subColor),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 13.sp, color: subColor)),
        ),
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

// ─── Dimensions Row ───────────────────────────────────────────────────────────

class _DimensionsRow extends StatelessWidget {
  final ShipmentDetail shipment;
  final bool isDark;

  const _DimensionsRow({required this.shipment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final subColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04),
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
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '$label  ',
            style: TextStyle(
              fontSize: 10.sp,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
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

// ─── Status Card ──────────────────────────────────────────────────────────────

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
            label: 'تاريخ التسليم',
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(label,
                style: TextStyle(
                    color: color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

// ─── Party Card ───────────────────────────────────────────────────────────────

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
    final subColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: _cardDecoration(surface, border, isDark),
      child: Row(
        children: [
          Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
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
                        fontSize: 11.sp,
                        color: subColor,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 2.h),
                Text('${party.firstName} ${party.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
                SizedBox(height: 2.h),
                Text(party.phoneNumber,
                    style: TextStyle(
                        fontSize: 12.sp, color: subColor, letterSpacing: 0.5)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => HapticFeedback.lightImpact(),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
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

// ─── Shared card decoration helper ────────────────────────────────────────────

BoxDecoration _cardDecoration(Color surface, Color border, bool isDark) {
  return BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: border),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
        blurRadius: 10,
        offset: const Offset(0, 3),
      ),
    ],
  );
}