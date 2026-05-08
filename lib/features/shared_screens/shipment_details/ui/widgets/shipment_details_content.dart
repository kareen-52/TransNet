

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/models/shipment_details_response.dart';

class ShipmentDetailsContent extends StatelessWidget {
  final ShipmentDetailsResponse data;

  const ShipmentDetailsContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final shipment = data.shipment;
    final driver = data.driver;
    final client = data.client;
    final geometry = data.route_geometry;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, shipment),
          verticalSpace(16),
          _sectionTitle(context, 'الموقع والمحافظات'),
          verticalSpace(8),
          _infoRow(context, Icons.location_on, 'من', shipment.startGovernorate),
          _infoRow(context, Icons.location_on, 'إلى', shipment.endGovernorate),
          verticalSpace(12),
          _sectionTitle(context, 'تفاصيل الشحنة'),
          verticalSpace(8),
          _infoRow(context, Icons.inventory_2_outlined, 'نوع المحمول', shipment.object ?? 'غير محدد'),
          _dimensionsRow(context, shipment),
          verticalSpace(8),
          _priceRow(context, shipment),
          if (shipment.insurance != null && shipment.insurance! > 0)
            _infoRow(context, Icons.security, 'التأمين', '${shipment.insurance} ل.س'),
          verticalSpace(12),
          
          // ✅ عرض السائق فقط إذا كان موجوداً
          if (driver != null) ...[
            _sectionTitle(context, 'السائق'),
            _partyInfo(context, driver),
            Divider(height: 24.h),
          ],
          
          // ✅ عرض العميل فقط إذا كان موجوداً
          if (client != null) ...[
            _sectionTitle(context, 'العميل'),
            _partyInfo(context, client),
            Divider(height: 24.h),
          ],
          
          _sectionTitle(context, 'معلومات إضافية'),
          verticalSpace(8),
          _infoRow(context, Icons.access_time, 'تاريخ التسليم', _formatDate(shipment.deliveryDeadline)),
          _infoRow(context, Icons.payments_outlined, 'حالة الدفع', shipment.paid == 1 ? 'مدفوع' : 'غير مدفوع'),
          _infoRow(context, Icons.check_circle_outline, 'حالة الإنجاز', shipment.success == 1 ? 'مكتملة' : 'قيد التنفيذ'),
          if (geometry != null) ...[
            verticalSpace(8),
            Text('عدد نقاط المسار: ${geometry.coordinates.length}', style: textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
  Widget _buildHeader(BuildContext context, ShipmentDetail shipment) {
    final isCompleted = shipment.success == 1;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(Icons.local_shipping, size: 28.sp, color: isCompleted ? Colors.green : Colors.orange),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#${shipment.shipmentNumber}', style: Theme.of(context).textTheme.titleMedium),
                Text(
                  shipment.status ?? (isCompleted ? 'مكتملة' : 'قيد التنفيذ'),
                  style: TextStyle(color: isCompleted ? Colors.green : Colors.orange[800]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
    );
  }

  Widget _infoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey.shade600),
          horizontalSpace(12),
          SizedBox(width: 100.w, child: Text('$label:', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _dimensionsRow(BuildContext context, ShipmentDetail shipment) {
    return Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      children: [
        if (shipment.width != null) _chip('العرض', shipment.width!),
        if (shipment.height != null) _chip('الارتفاع', shipment.height!),
        if (shipment.length != null) _chip('الطول', shipment.length!),
        if (shipment.weight != null) _chip('الوزن', '${shipment.weight} كغم'),
      ],
    );
  }

  Widget _chip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20.r)),
      child: Text('$label: $value', style: TextStyle(fontSize: 12.sp)),
    );
  }

  Widget _priceRow(BuildContext context, ShipmentDetail shipment) {
    return Row(
      children: [
        Icon(Icons.attach_money, size: 18.sp, color: AppColors.primary),
        horizontalSpace(8),
        Text('السعر:', style: TextStyle(fontWeight: FontWeight.w500)),
        horizontalSpace(4),
        Text(
          '${shipment.price ?? 0} ل.س',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _partyInfo(BuildContext context, PartyInfo party) {
    return Column(
      children: [
        _infoRow(context, Icons.person, 'الاسم', '${party.firstName} ${party.lastName}'),
        _infoRow(context, Icons.phone, 'الهاتف', party.phoneNumber),
        _infoRow(context, Icons.badge, 'رقم المستخدم', party.userNumber),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'غير محدد';
    final parts = dateString.split(' ');
    if (parts.length >= 2) {
      final date = parts[0].split('-').reversed.join('/');
      final time = parts[1].substring(0, 5);
      return '$date $time';
    }
    return dateString;
  }
}