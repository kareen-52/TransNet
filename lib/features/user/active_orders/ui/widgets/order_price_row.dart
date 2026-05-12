import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPriceRow extends StatelessWidget {
  final double price;

  const OrderPriceRow({super.key, required this.price});

  String _formatPrice(double val) {
    if (val >= 1000000) return '${(val / 1000000).toStringAsFixed(1)}M';
    if (val >= 1000) return '${(val / 1000).toStringAsFixed(1)}K';
    return val.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'إجمالي التكلفة',
          style: TextStyle(
            fontSize: 12.sp,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        Text(
          '${_formatPrice(price)} ل.س',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}