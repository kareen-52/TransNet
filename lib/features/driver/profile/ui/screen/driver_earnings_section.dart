import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import '../widgets/statistics/current_settlement_hero_card.dart';
import '../widgets/statistics/lifetime_stats_card.dart';
import '../widgets/statistics/quick_stats_grid.dart';
import '../widgets/statistics/transactions_history_list.dart';

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
          'الأرباح والإحصائيات',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
            verticalSpace(32),

            // 2. شبكة الإحصائيات السريعة
            Text('نظرة عامة', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            verticalSpace(16),
            QuickStatsGrid(stats: stats),
            verticalSpace(32),

            // 3. الإحصائيات التراكمية (الكلية)
            Text('الإحصائيات التراكمية', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            verticalSpace(16),
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
                title: 'سجل الضرائب (مستحقات التطبيق)',
                transactions: stats.allTaxes,
                activeColor: AppColors.error, 
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