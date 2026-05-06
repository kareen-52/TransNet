import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/features/user/home_screen/ui/screens/home_entities.dart';

class OrderTimeline extends StatelessWidget {
  final List<TimelineStepModel> steps;
  const OrderTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(steps.length, (index) {
            final isLast = index == steps.length - 1;
            return Expanded(
              flex: isLast ? 0 : 1,
              child: Row(
                children: [
                  _buildStatusIndicator(steps[index]),
                  if (!isLast)
                    _buildLine(
                      isDone:
                          steps[index + 1].isDone || steps[index + 1].isActive,
                    ),
                ],
              ),
            );
          }),
        ),

        verticalSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: steps.map((step) => _buildLabel(step)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(TimelineStepModel step) {
    return step.isActive
        ? const _ActiveDot()
        : _StandardDot(isDone: step.isDone);
  }

  Widget _buildLine({required bool isDone}) {
    return Builder(
      builder: (context) {
        return Expanded(
          child: Container(
            height: 4.h,
            color: isDone
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        );
      },
    );
  }

  Widget _buildLabel(TimelineStepModel step) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Text(
          step.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: step.isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: step.isActive
                ? FontWeightHelper.bold
                : FontWeightHelper.regular,
            fontSize: 12.sp,
          ),
        );
      },
    );
  }
}

class _StandardDot extends StatelessWidget {
  final bool isDone;
  const _StandardDot({required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16.w,
      height: 16.h,
      decoration: BoxDecoration(
        color: isDone
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _ActiveDot extends StatelessWidget {
  const _ActiveDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 4.w,
        ),
      ),
      child: Center(
        child: Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 3.w,
            ),
          ),
        ),
      ),
    );
  }
}
