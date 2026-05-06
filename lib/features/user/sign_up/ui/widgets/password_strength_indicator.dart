import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/app_regex.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final bool showMissingRequirements; 

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    this.showMissingRequirements = true,
  });

  @override
  Widget build(BuildContext context) {
    final strengthInfo = AppRegex.getPasswordStrengthInfo(password);
    final missing = AppRegex.getMissingPasswordRequirements(password);

    return Column(
      children: [
   
        Row(
          children: List.generate(5, (index) {
            final isActive = index < AppRegex.getPasswordStrength(password);
            return Expanded(
              child: Container(
                height: 4.h,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  color: isActive ? strengthInfo.color : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            );
          }),
        ),
        verticalSpace(8),
        // النص الوصفي
        if (strengthInfo.text.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              strengthInfo.text,
              style: TextStyle(
                color: strengthInfo.color,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        // المتطلبات المفقودة
        if (showMissingRequirements && missing.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'ينقص: ${missing.join('، ')}',
              style: TextStyle(color: Colors.grey[600], fontSize: 11.sp),
            ),
          ),
   
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'يجب أن تحتوي على 8 أحرف على الأقل، حرف كبير، حرف صغير، رقم، رمز خاص',
            style: TextStyle(color: Colors.grey[400], fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
