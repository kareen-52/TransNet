import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/statistics/formatters.dart'; // ملف التنسيق (مرفق بالأسفل)

class CurrentSettlementHeroCard extends StatelessWidget {
  final DriverStatisticsModel stats;

  const CurrentSettlementHeroCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark ?? AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              horizontalSpace(12),
              Text(
                'أرباحي الصافية (قيد التسوية)',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          Text(
            '${Formatters.formatNumber(stats.myEarnings)} ل.س',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          verticalSpace(24),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSubStat(
                  'إجمالي التسوية',
                  stats.unpaidAmount,
                  Icons.monetization_on_outlined,
                ),
                Container(
                  width: 1,
                  height: 40.h,
                  color: Colors.white.withOpacity(0.2),
                ),
                horizontalSpace(2),
                _buildSubStat(
                  'مستحقات التطبيق (15%)',
                  stats.amountToPay,
                  Icons.pie_chart_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubStat(String title, double amount, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.7), size: 14.sp),
              horizontalSpace(6),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          verticalSpace(4),
          Text(
            '${Formatters.formatNumber(amount)} ل.س',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
