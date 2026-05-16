import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import '../../logic/active_orders_cubit.dart';
import '../../logic/active_orders_state.dart';
import '../widgets/active_order_card.dart';
import 'active_orders_shimmer.dart';

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ActiveOrdersCubit, ActiveOrdersState>(
          builder: (context, state) {
            int ordersCount = state.maybeWhen(
              loaded: (orders) => orders.length,
              orElse: () => 0,
            );

            return _buildSectionHeader(context, ordersCount);
          },
        ),

        verticalSpace(16),
        BlocBuilder<ActiveOrdersCubit, ActiveOrdersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const ActiveOrdersShimmer(),
              loaded: (orders) => SizedBox(
                height: 280.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  itemCount: orders.length,
                  separatorBuilder: (context, index) => horizontalSpace(16),
                  itemBuilder: (context, index) =>
                      ActiveOrderCard(order: orders[index]),
                ),
              ),
              empty: () => EmptyStateWidget(
                title: 'لا توجد طلبات نشطة حالياً',
                onRetry: () =>
                    context.read<ActiveOrdersCubit>().fetchActiveOrders(),
              ),
              error: (error) => ErrorStateWidget(
                message: error.getAllErrorMessages(),
                onRetry: () =>
                    context.read<ActiveOrdersCubit>().fetchActiveOrders(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, int count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'الطلبات النشطة',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          ),
          if (count > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '$count طلب نشط',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
