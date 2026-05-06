import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpPinInput extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const OtpPinInput({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTheme = PinTheme(
      width: 50.w,
      height: 80.h,
      textStyle: theme.textTheme.titleLarge,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.colorScheme.outline),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        length: 6,
        enabled: enabled,
        defaultPinTheme: defaultTheme,
        focusedPinTheme: defaultTheme.copyDecorationWith(
          border: Border.all(color: theme.colorScheme.primary, width: 2),
        ),
        showCursor: enabled,
        autofocus: enabled,
        errorPinTheme: defaultTheme.copyDecorationWith(
          color: theme.colorScheme.errorContainer,
          border: Border.all(color: theme.colorScheme.error, width: 2),
        ),
        closeKeyboardWhenCompleted: true,
        disabledPinTheme: defaultTheme.copyWith(
          decoration: defaultTheme.decoration!.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.05),
          ),
        ),
        keyboardType: TextInputType.number,
        pinAnimationType: PinAnimationType.scale,
        submittedPinTheme: defaultTheme.copyDecorationWith(
          border: Border.all(color: theme.colorScheme.primary, width: 2),
        ),
        onCompleted: (pin) {
          debugPrint("OTP: $pin");
        },
      ),
    );
  }
}