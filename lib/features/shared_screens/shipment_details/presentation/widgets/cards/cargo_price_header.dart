import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_entity.dart';


class CargoPriceHeader extends StatelessWidget {
  final ShipmentEntity shipment;

  const CargoPriceHeader({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Expanded(child: _PriceLabel(price: shipment.price)),
    );
  }
}

class _PriceLabel extends StatelessWidget {
  final int? price;
  const _PriceLabel({required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'السعر الإجمالي',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${price ?? 0}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            SizedBox(width: 4.w),
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                'ل.س',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// class _InsuranceBadge extends StatelessWidget {
//   const _InsuranceBadge();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.15),
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.security_rounded, color: Colors.white, size: 18.sp),
//           SizedBox(height: 3.h),
//           Text(
//             'مؤمَّن',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 11.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           Text(
//             'تأمين',
//             style: TextStyle(
//               color: Colors.white.withValues(alpha: 0.70),
//               fontSize: 9.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
