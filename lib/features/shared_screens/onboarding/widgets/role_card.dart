import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String imagePath;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: backgroundColor.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Column(
          children: [
  
            Container(
              height: 80.h,
              width: 80.h,
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            verticalSpace(16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
     
                  ),
            ),
            verticalSpace(4),
          
          ],
        ),
      ),
    );
  }
}