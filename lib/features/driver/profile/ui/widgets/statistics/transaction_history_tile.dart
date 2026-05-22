import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/driver/profile/data/models/driver_statistics_model.dart';

class TransactionHistoryTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<FinancialTransactionModel> transactions;

  const TransactionHistoryTile({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.transactions,
  });

  String _formatNumber(double num) {
    return num.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: color,
          collapsedIconColor: theme.iconTheme.color,
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          title: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          children: transactions.isEmpty
              ? [Padding(padding: EdgeInsets.all(16.w), child: Text('لا توجد سجلات حالياً.', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)))]
              : transactions.map((t) {
                  return Column(
                    children: [
                      Divider(height: 1, color: theme.colorScheme.outline.withOpacity(0.2)),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                        title: Text('${_formatNumber(t.value)} ل.س', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900, color: color)),
                        subtitle: Text(t.createdAt.split('T')[0], style: theme.textTheme.bodySmall),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: t.isReceived ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            t.isReceived ? 'مكتملة' : 'معلقة',
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: t.isReceived ? Colors.green : Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
        ),
      ),
    );
  }
}