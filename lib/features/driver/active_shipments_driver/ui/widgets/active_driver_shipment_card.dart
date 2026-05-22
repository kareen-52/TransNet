import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/data/models/active_driver_shipment_model.dart';
import 'package:graduation_progect/features/user/active_orders/ui/helpers/shipment_status_helper.dart';
import 'package:graduation_progect/features/user/active_orders/ui/widgets/driver_info_row.dart';

class ActiveDriverShipmentCard extends StatelessWidget {
  final ActiveDriverShipmentModel shipment;

  const ActiveDriverShipmentCard({super.key, required this.shipment});

  bool get _isPickup => shipment.status == 'جارية';
  bool get _isDelivery => shipment.status == 'قيد التوصيل';

  String get _statusLabel {
    if (_isPickup) return 'جارية';
    if (_isDelivery) return 'قيد التوصيل';
    return shipment.status;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = ShipmentStatusHelper.getColor(shipment.status);

    return GestureDetector(
      onTap: () => _navigateToTracking(context),
      child: Container(
        width: 300.w,
        margin: EdgeInsetsDirectional.only(end: 12.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: statusColor.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header: حالة + رقم الشحنة ─────────────────────────────
              _buildHeader(theme, statusColor),
              verticalSpace(12),

              // ── المسار: من → إلى ──────────────────────────────────────
              _buildRoute(theme),
              verticalSpace(12),

              Divider(height: 1, color: theme.colorScheme.outline),
              verticalSpace(12),

              // ── السعر + معلومات العميل ──────────────────────────────────
              _buildBottomSection(theme, context),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader(ThemeData theme, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            _statusLabel,
            style: TextStyle(
              fontSize: 10.sp,
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          '#${shipment.shipmentNumber}',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  // ─── Route ────────────────────────────────────────────────────────────────
  Widget _buildRoute(ThemeData theme) {
    return Row(
      children: [
        // الأيقونات
        Column(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 1,
              height: 28.h,
              margin: EdgeInsets.symmetric(vertical: 3.h),
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        horizontalSpace(10),

        // النصوص
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shipment.startGovernorate,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(12),
              Text(
                shipment.endGovernorate,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // سهم الدخول
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14.sp,
          color: theme.colorScheme.onSurface.withOpacity(0.3),
        ),
      ],
    );
  }

  // ─── Bottom row: السعر + العميل ───────────────────────────────────────────
  Widget _buildBottomSection(ThemeData theme, BuildContext context) {
    return Column(
      children: [
        // 1. سطر السعر
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'السعر',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _formatPrice(shipment.price),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: ' ل.س',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // 2. سطر العميل (التصميم الجديد المتجاوب)
        if (shipment.client != null) ...[
          verticalSpace(12),
          _buildClientInfoRow(theme, context, shipment.client!),
        ],
      ],
    );
  }

  // ─── Client Info Row (التصميم المطلوب) ────────────────────────────────────
  Widget _buildClientInfoRow(
    ThemeData theme,
    BuildContext context,
    ActiveShipmentClientInfo client,
  ) {
    final fullName = client.fullName;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              CircleAvatar(
                radius: 18.r, // تصغير الحجم قليلاً ليناسب الكارد
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.primary,
                  size: 20.sp,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: fullName,
                  child: Text(
                    fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.sp,
                      color: theme.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        horizontalSpace(8),
        GestureDetector(
          onTap: () => callUser(context, client.phoneNumber),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.phone_rounded,
                  color: theme.colorScheme.primary,
                  size: 14.sp,
                ),
                horizontalSpace(4),
                Text(
                  'اتصال',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Actions ──────────────────────────────────────────────────────────────
  void _navigateToTracking(BuildContext context) {
    // نبني الـ ShipmentMapData من بيانات الشحنة النشطة
    // final mapData = ShipmentMapData(
    //   id: shipment.id,
    //   startLat: shipment.startLat,
    //   startLng: shipment.startLng,
    //   endLat: shipment.endLat,
    //   endLng: shipment.endLng,
    //   pathCoordinates: shipment.pathCoordinates,
    // );

    Navigator.pushNamed(
      context,
      Routes.driverTrackingScreen,
      arguments: shipment,
    );
  }
}

String _formatPrice(double price) {
  if (price >= 1000000) return '${(price / 1000000).toStringAsFixed(1)}M';
  if (price >= 1000) return '${(price / 1000).toStringAsFixed(0)}K';
  return price.toStringAsFixed(0);
}
