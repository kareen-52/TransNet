import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'financial_summary_card.dart';

class QuickStatsGrid extends StatelessWidget {
  final DriverStatisticsModel stats;

  const QuickStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FinancialSummaryCard(
                title: 'مكافآت معلقة',
                amount: stats.unreceivedBonusesSum,
                icon: Icons.star_rounded,
                color: AppColors.success,
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: FinancialSummaryCard(
                title: 'ضرائب معلقة',
                amount: stats.unreceivedTaxesSum,
                icon: Icons.money_off_rounded,
                color: AppColors.error,
              ),
            ),
          ],
        ),
        verticalSpace(12),
        Row(
          children: [
            Expanded(
              child: FinancialSummaryCard(
                title: 'شحنات التسوية',
                amount: stats.unpaidCount.toDouble(),
                icon: Icons.pending_actions_rounded,
                color: AppColors.secondary,
                isCurrency: false,
              ),
            ),
            horizontalSpace(12),
            Expanded(
              child: FinancialSummaryCard(
                title: 'إجمالي الشحنات',
                amount: stats.total.toDouble(),
                icon: Icons.check_circle_rounded,
                color: AppColors.primary,
                isCurrency: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}