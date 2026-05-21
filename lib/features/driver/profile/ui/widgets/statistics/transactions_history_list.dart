import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/formatters.dart';

class TransactionsHistoryList extends StatelessWidget {
  final String title;
  final List<FinancialTransactionModel> transactions;
  final Color activeColor;
  final IconData icon;
  final String receivedLabel;
  final String pendingLabel;

  const TransactionsHistoryList({
    super.key,
    required this.title,
    required this.transactions,
    required this.activeColor,
    required this.icon,
    required this.receivedLabel,
    required this.pendingLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الهيدر
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: activeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${transactions.length} بند',
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: activeColor),
              ),
            ),
          ],
        ),
        verticalSpace(12),
        
        // القائمة
        Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: cs.outline.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: transactions.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              indent: 70.w,
              endIndent: 20.w,
              color: cs.outline.withOpacity(0.1),
            ),
            itemBuilder: (context, i) {
              final t = transactions[i];
              final isSuccess = t.isReceived;
              final statusColor = isSuccess ? AppColors.success : AppColors.warning;
              final statusLabel = isSuccess ? receivedLabel : pendingLabel;

              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: statusColor, size: 20.sp),
                    ),
                    horizontalSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'بند رقم #${t.id}',
                            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (t.createdAt.isNotEmpty) ...[
                            verticalSpace(4),
                            Text(
                              Formatters.formatDate(t.createdAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: cs.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${Formatters.formatNumber(t.value)} ل.س',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: activeColor,
                          ),
                        ),
                        verticalSpace(4),
                        Row(
                          children: [
                            Icon(
                              isSuccess ? Icons.check_circle_rounded : Icons.access_time_filled_rounded,
                              size: 12.sp,
                              color: statusColor,
                            ),
                            horizontalSpace(4),
                            Text(
                              statusLabel,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}