import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';

class OrderProgressTracker extends StatelessWidget {
  final String status;
  const OrderProgressTracker({super.key, required this.status});

  static const List<String> _steps = [
    'تم الإرسال',
    'تم القبول',
    'في الطريق',
    'تم التسليم',
  ];

  int get _currentStepIndex {
    switch (status) {
      case 'جارية':
        return 1;
      case 'قيد التوصيل':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final inactive = theme.colorScheme.onSurface.withOpacity(0.25);

    return Column(
      children: [
        SizedBox(
          height: 20.h,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              // --- الخطوط بين النقاط (خلفية) ---
              Row(
                children: List.generate(_steps.length - 1, (i) {
                  return Expanded(
                    child: Container(
                      height: 3.h,
                      color: i < _currentStepIndex ? primary : inactive,
                    ),
                  );
                }),
              ),
              // --- النقاط (فوق الخطوط) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_steps.length, (i) {
                  final isCompleted = i < _currentStepIndex;
                  final isCurrent = i == _currentStepIndex;
                  final isActive = i <= _currentStepIndex;
                  return _buildDot(
                    isActive,
                    isCurrent,
                    isCompleted,
                    primary,
                    inactive,
                  );
                }),
              ),
            ],
          ),
        ),

        verticalSpace(10),

        Row(
          children: List.generate(_steps.length, (i) {
            final isCurrent = i == _currentStepIndex;
            return Expanded(
              child: Center(
                child: Text(
                  _steps[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCurrent
                        ? primary
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDot(
    bool isActive,
    bool isCurrent,
    bool isCompleted,
    Color primary,
    Color inactive,
  ) {
    return Container(
      width: isCurrent ? 20.w : 14.w,
      height: isCurrent ? 20.w : 14.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? primary : inactive,
        border: isCurrent
            ? Border.all(color: primary.withOpacity(0.3), width: 4.w)
            : null,
      ),
      child: isCompleted
          ? Center(
              child: Icon(Icons.check, color: Colors.white, size: 10.sp),
            )
          : null,
    );
  }
}
