import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/current_settlement_hero_card.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/lifetime_stats_card.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/quick_stats_grid.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/transactions_history_list.dart';


class DriverEarningsScreen extends StatelessWidget {
  final DriverStatisticsModel stats;

  const DriverEarningsScreen({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'الأرباح والمالية',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. البطاقة الرئيسية (تسوية الدورة الحالية)
            CurrentSettlementHeroCard(stats: stats),
            verticalSpace(24),

            // 2. شبكة الإحصائيات السريعة
            Text(
              'نظرة عامة',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalSpace(12),
            QuickStatsGrid(stats: stats),
            verticalSpace(24),

            // 3. الإحصائيات التراكمية (الكلية)
            Text(
              'الإحصائيات التراكمية',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            verticalSpace(12),
            LifetimeStatsCard(stats: stats),
            verticalSpace(32),

            // 4. سجل المكافآت
            if (stats.allBonuses.isNotEmpty) ...[
              TransactionsHistoryList(
                title: 'سجل المكافآت',
                transactions: stats.allBonuses,
                activeColor: AppColors.success,
                icon: Icons.card_giftcard_rounded,
                receivedLabel: 'مستلمة',
                pendingLabel: 'معلقة',
              ),
              verticalSpace(32),
            ],

            // 5. سجل الضرائب والاستقطاعات
            if (stats.allTaxes.isNotEmpty) ...[
              TransactionsHistoryList(
                title: 'سجل الضرائب والاستقطاعات',
                transactions: stats.allTaxes,
                activeColor: AppColors.warning, // أو لون أحمر حسب الثيم
                icon: Icons.receipt_long_rounded,
                receivedLabel: 'مدفوعة',
                pendingLabel: 'غير مدفوعة',
              ),
            ],
          ],
        ),
      ),
    );
  }
}