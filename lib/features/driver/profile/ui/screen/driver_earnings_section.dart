import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/earnings_detail_row.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/earnings_info_card.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/transaction_history_tile.dart';

class DriverEarningsScreen extends StatelessWidget {
  final DriverStatisticsModel stats;

  const DriverEarningsScreen({super.key, required this.stats});

  String _formatNumber(double num) {
    return num.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('الأرباح والإحصائيات'), elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(theme, 'نظرة عامة على نشاطك'),
            verticalSpace(12),
            Row(
              children: [
                Expanded(
                  child: EarningsInfoCard(
                    title: 'إجمالي الطلبات',
                    value: '${stats.total} طلب',
                    description: 'جميع الشحنات المنجزة',
                    icon: Icons.local_shipping_rounded,
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: EarningsInfoCard(
                    title: 'قيمة الشحنات',
                    value: _formatNumber(stats.totalPrice),
                    description: 'إجمالي أجور التوصيل',
                    icon: Icons.account_balance_wallet_rounded,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            verticalSpace(24),

            _buildSectionTitle(theme, 'الدورة المالية الحالية (غير المسواة)'),
            verticalSpace(12),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  EarningsDetailRow(
                    title: 'عدد الطلبات المعلقة',
                    value: '${stats.unpaidCount}',
                    icon: Icons.pending_actions_rounded,
                  ),
                  Divider(color: theme.colorScheme.outline.withOpacity(0.2)),
                  EarningsDetailRow(
                    title: 'المبالغ الكلية المحصلة',
                    value: '${_formatNumber(stats.unpaidAmount)} ل.س',
                    icon: Icons.attach_money_rounded,
                  ),
                  Divider(color: theme.colorScheme.outline.withOpacity(0.2)),
                  EarningsDetailRow(
                    title: 'أرباحك الصافية (85%)',
                    value: '${_formatNumber(stats.myEarnings)} ل.س',
                    icon: Icons.savings_rounded,
                    valueColor: AppColors.success,
                  ),
                  Divider(color: theme.colorScheme.outline.withOpacity(0.2)),
                  EarningsDetailRow(
                    title: 'عمولة التطبيق (15%)',
                    value: '${_formatNumber(stats.amountToPay)} ل.س',
                    icon: Icons.pie_chart_rounded,
                    valueColor: AppColors.error,
                  ),
                ],
              ),
            ),
            verticalSpace(24),

            _buildSectionTitle(theme, 'التسويات (المعلقة)'),
            verticalSpace(12),
            Row(
              children: [
                Expanded(
                  child: EarningsInfoCard(
                    title: 'مكافآت لك',
                    value: '+${_formatNumber(stats.unreceivedBonusesSum)}',
                    description: 'تخصم من ديونك للتطبيق',
                    icon: Icons.card_giftcard_rounded,
                    color: AppColors.success,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: EarningsInfoCard(
                    title: 'ضرائب/خصومات',
                    value: '-${_formatNumber(stats.unreceivedTaxesSum)}',
                    description: 'تضاف لديونك للتطبيق',
                    icon: Icons.warning_amber_rounded,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
            verticalSpace(24),

            _buildSectionTitle(theme, 'التسوية النهائية'),
            verticalSpace(12),
            _buildFinalAmountCard(theme),

            verticalSpace(24),
            _buildSectionTitle(theme, 'سجلات العمليات المالية'),
            verticalSpace(12),
            TransactionHistoryTile(
              title: 'سجل المكافآت',
              icon: Icons.star_rounded,
              color: AppColors.success,
              transactions: stats.allBonuses,
            ),
            verticalSpace(12),
            TransactionHistoryTile(
              title: 'سجل الضرائب والخصومات',
              icon: Icons.money_off_rounded,
              color: AppColors.error,
              transactions: stats.allTaxes,
            ),

            verticalSpace(40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
    );
  }


  Widget _buildFinalAmountCard(ThemeData theme) {

    final bool isAppOwesDriver = stats.totalAmountToPay < 0;
    final double absoluteAmount = stats.totalAmountToPay.abs();
    final Color cardColor = isAppOwesDriver
        ? AppColors.success
        : AppColors.primary;
    final String titleText = isAppOwesDriver
        ? 'المبلغ المستحق لك من التطبيق'
        : 'المبلغ المطلوب تسديده للتطبيق';
    final String subText = isAppOwesDriver
        ? 'بسبب المكافآت، أصبح رصيدك إيجابياً والتطبيق مدين لك.'
        : 'هذا المبلغ يشمل عمولة التطبيق بعد حساب المكافآت والخصومات.';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cardColor, cardColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            titleText,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace(12),
          Text(
            '${_formatNumber(absoluteAmount)} ل.س',
            style: TextStyle(
              fontSize: 34.sp,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          verticalSpace(12),
          Text(
            subText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
