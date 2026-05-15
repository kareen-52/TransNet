import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class PinInputDialog extends StatelessWidget {
  final Function(String) onCompleted;
  const PinInputDialog({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('أدخل رمز التسليم', textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('يرجى أخذ الرمز المكون من 6 أرقام من العميل.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp)),
          verticalSpace(20),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              autofocus: true,
              onCompleted: onCompleted,
              defaultPinTheme: PinTheme(
                width: 45.w,
                height: 55.h,
                textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
      ],
    );
  }
}