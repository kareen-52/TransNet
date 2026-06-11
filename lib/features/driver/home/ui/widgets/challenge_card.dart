import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/spacing.dart';

class ChallengeCard extends StatelessWidget {
  final bool isAvailable;
  final int completedShipments;
  final int targetShipments = 15;

  const ChallengeCard({
    super.key,
    required this.isAvailable,
    required this.completedShipments,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final progress = completedShipments.clamp(0, targetShipments);

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.secondary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'تحدي اليوم',
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  horizontalSpace(4),
                  Icon(
                    Icons.auto_awesome,
                    color: theme.colorScheme.secondary,
                    size: 14.sp,
                  ),
                ],
              ),
              if (!isAvailable)
                Icon(
                  Icons.lock_outline,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20.sp,
                ),
            ],
          ),

          verticalSpace(16),

          Text(
            'أكملت $progress من $targetShipments رحلة',
            style: textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.secondary,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          verticalSpace(8),

          Row(
            children: [
              const Text('🏆'),
              horizontalSpace(4),
              Text(
                'باقي ${targetShipments - progress} طلبات لتحصل على مكافأة 30,000 ل.س',
                style: textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),

          verticalSpace(24),

          _buildProgressBar(context, progress, targetShipments),

          if (!isAvailable) ...[
            verticalSpace(16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                'التقدم متوقف. انتقل الى وضع المتاح للمتابعة.',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, int progress, int target) {
    final theme = Theme.of(context);
    final milestones = [15, 10, 5, 0];

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final progressWidth = (progress / target) * maxWidth;

            return Stack(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 6.h,
                  width: double.infinity,
                  decoration: BoxDecoration(

                    color: Colors.grey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                Positioned(
                  right: 0,

                  child: Container(
                    height: 6.h,
                    width: progressWidth,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),

                ...milestones.map((milestone) {
                  final position = (milestone / target) * maxWidth;
                  final isReached = progress >= milestone;

                  return Positioned(
                    right: position - 7.w,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: isReached
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.onSecondary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isReached
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.secondary.withOpacity(0.8),
                          width: 2,
                        ),
                      ),
                      child: milestone == target && isReached
                          ? Icon(Icons.check, size: 8.sp, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),

        verticalSpace(12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: milestones.reversed
              .map(
                (m) =>
                    _progressLabel(context, '$m رحلة', active: progress >= m),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _progressLabel(
    BuildContext context,
    String text, {
    bool active = false,
  }) {
    final theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        fontSize: 10.sp,
        color: active
            ? theme.colorScheme.secondary
            : theme.colorScheme.secondary,
        fontWeight: active ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
