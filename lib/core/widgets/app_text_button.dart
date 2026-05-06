import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final TextStyle? textStyle;
  final Widget? prefixIcon, suffixIcon;
  final bool isDisabled;
  final bool isLoading;
  final Color? backgroundColor;
  final double borderRadius;
  final BorderSide? borderSide;

  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 52,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisabled = false,
    this.isLoading = false,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? width!.w : double.infinity,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: borderSide ?? BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
        ),

        onPressed: (isDisabled || isLoading) ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[prefixIcon!, horizontalSpace(8)],
                  Text(
                    text,
                    style:
                        textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (suffixIcon != null) ...[horizontalSpace(8), suffixIcon!],
                ],
              ),
      ),
    );
  }
}
