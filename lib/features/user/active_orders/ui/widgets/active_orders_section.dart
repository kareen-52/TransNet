import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/animation_constants.dart';
import 'package:lottie/lottie.dart';
import '../../logic/active_orders_cubit.dart';
import '../../logic/active_orders_state.dart';
import 'active_order_card.dart';
import 'active_orders_shimmer.dart';


class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 4.w),
          child: Text(
            'الطلبات النشطة',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        SizedBox(height: 14.h),

        BlocBuilder<ActiveOrdersCubit, ActiveOrdersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const ActiveOrdersShimmer(),
              loaded: (orders) => _buildOrdersList(orders),
              empty: () => _buildEmpty(context),
              error: (error) => _buildError(context, error.getAllErrorMessages()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOrdersList(orders) {
    return SizedBox(
      height: 210.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: EdgeInsetsDirectional.only(start: 4.w),
        itemCount: orders.length,
        itemBuilder: (context, index) => ActiveOrderCard(order: orders[index]),
      ),
    );
  }


  Widget _buildEmpty(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
        ),
      ),
      child: Column(
        children: [
          Lottie.asset(
            AnimationConstants.emptyState,
            width: 100.w,
            height: 80.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8.h),
          Text(
            'لا يوجد طلبات نشطة حالياً',
            style: TextStyle(
              fontSize: 13.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildError(BuildContext context, String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withOpacity(0.25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () =>
                context.read<ActiveOrdersCubit>().fetchActiveOrders(),
            icon: Icon(
              Icons.refresh_rounded,
              size: 16.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: Text(
              'إعادة المحاولة',
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
