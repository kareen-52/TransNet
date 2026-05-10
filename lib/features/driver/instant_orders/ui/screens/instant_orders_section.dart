import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/instant_orders/logic/instant_orders_cubit.dart';
import 'package:graduation_progect/features/driver/instant_orders/logic/instant_orders_state.dart';
import 'package:graduation_progect/features/driver/instant_orders/ui/widgets/instant_order_card.dart';

class InstantOrdersSection extends StatelessWidget {
  const InstantOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الطلبات الفورية',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpace(12),

        BlocBuilder<InstantOrdersCubit, InstantOrdersState>(
          builder: (context, state) {
            return state.maybeWhen(
              
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: CircularProgressIndicator(color: theme.colorScheme.primary),
                ),
              ),
              
              empty: () => _buildEmptyState(theme),
              
              error: (errorModel) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Column(
                    children: [
                      Icon(Icons.wifi_off_rounded, size: 50.sp, color: theme.colorScheme.error.withOpacity(0.5)),
                      verticalSpace(12),
                      Text('تعذر جلب الطلبات، تحقق من اتصالك.', style: TextStyle(color: theme.colorScheme.error, fontSize: 14.sp)),
                    ],
                  ),
                ),
              ),


              success: (orders) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final data = orders[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: InstantOrderCard(
                      key: ValueKey('order_${data.userId}_${data.expiresAt}'),
                      orderData: data, 
                      onOrderProcessed: () => context.read<InstantOrdersCubit>().removeOrderLocally(data.userId),
                    ),
                  );
                },
              ),

              orElse: () => _buildEmptyState(theme),
            );
          },
        ),
      ],
    );
  }



  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            Icon(Icons.radar, size: 50.sp, color: theme.colorScheme.primary.withOpacity(0.5)),
            verticalSpace(12),
            Text(
              'جاري البحث عن طلبات قريبة منك...',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}