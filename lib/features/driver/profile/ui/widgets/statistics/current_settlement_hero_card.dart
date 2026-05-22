import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';
import 'formatters.dart';

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
          colors: [AppColors.primary, AppColors.primaryDark ?? AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12.r)),
                child: Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 20.sp),
              ),
              horizontalSpace(12),
              Text(
                'أرباحي الصافية (قيد التسوية)',
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          verticalSpace(16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${Formatters.formatNumber(stats.myEarnings)} ل.س',
              style: TextStyle(color: Colors.white, fontSize: 38.sp, fontWeight: FontWeight.w900, height: 1.1),
            ),
          ),
          verticalSpace(24),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.15), borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSubStat('إجمالي الأجور', stats.unpaidAmount, Icons.monetization_on_rounded, Colors.white),
                Container(width: 1, height: 35.h, color: Colors.white.withOpacity(0.2)),
                _buildSubStat('عمولة التطبيق', stats.amountToPay, Icons.pie_chart_rounded, Colors.orangeAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubStat(String title, double amount, IconData icon, Color iconColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 14.sp),
              horizontalSpace(6),
              Text(title, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10.sp)),
            ],
          ),
          verticalSpace(6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text('${Formatters.formatNumber(amount)} ل.س', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}