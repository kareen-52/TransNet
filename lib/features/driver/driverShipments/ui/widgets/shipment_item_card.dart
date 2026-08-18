import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/driverShipments/data/driver_shipments_response.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/screens/shipment_details_screen.dart';

class ShipmentItemCard extends StatelessWidget {
  final ShipmentModel shipment;
  const ShipmentItemCard({super.key, required this.shipment});

  String _formatDimension(String? value) {
    if (value == null || value.isEmpty) return '—';
    return '$value سم';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final bool isCompleted = shipment.isCompleted;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ShipmentDetailsScreen(shipmentId: shipment.id ?? 0),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 20.sp,
                        color: isCompleted ? Colors.green : Colors.orange,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "#${shipment.shipmentNumber ?? 'غير معروف'}",
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Colors.green.withOpacity(0.2)
                          : Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      shipment.status ??
                          (isCompleted ? "مكتملة" : "قيد التنفيذ"),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isCompleted
                            ? Colors.green[800]
                            : Colors.orange[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          "${shipment.startGovernorate ?? 'غير محدد'} → ${shipment.endGovernorate ?? 'غير محدد'}",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 18.sp,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "الشيء: ${shipment.object ?? 'غير محدد'}",
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 16.w,
                    runSpacing: 8.h,
                    children: [
                      _buildInfoChip(
                        context,
                        icon: Icons.straighten,
                        label: "العرض",
                        value: _formatDimension(shipment.width),
                      ),
                      _buildInfoChip(
                        context,
                        icon: Icons.height,
                        label: "الارتفاع",
                        value: _formatDimension(shipment.height),
                      ),
                      _buildInfoChip(
                        context,
                        icon: Icons.timeline,
                        label: "الطول",
                        value: _formatDimension(shipment.length),
                      ),
                      _buildInfoChip(
                        context,
                        icon: Icons.fitness_center,
                        label: "الوزن",
                        value: shipment.weight != null
                            ? "${shipment.weight} كغم"
                            : "—",
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoRow(
                        icon: Icons.attach_money,
                        label: "السعر",
                        value: "${shipment.price ?? 0} ل.س",
                        valueStyle: textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (shipment.userId != null || shipment.driverId != null)
                    Divider(height: 16.h, thickness: 0.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: Colors.grey.shade700),
          SizedBox(width: 4.w),
          Text(
            "$label: $value",
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    TextStyle? valueStyle,
    double fontSize = 14,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey.shade600),
        SizedBox(width: 8.w),
        Text(
          "$label: ",
          style: TextStyle(fontSize: fontSize.sp, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style:
              valueStyle ??
              TextStyle(fontSize: fontSize.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
