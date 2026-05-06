import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/home/logic/driver_home_state.dart';
import 'package:graduation_progect/features/driver/home/ui/widgets/instant_order_card.dart';

class InstantOrdersSection extends StatefulWidget {
  const InstantOrdersSection({super.key});

  @override
  State<InstantOrdersSection> createState() => _InstantOrdersSectionState();
}

class _InstantOrdersSectionState extends State<InstantOrdersSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الطلبات الفورية',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(16),

        BlocBuilder<DriverHomeCubit, DriverHomeState>(
          buildWhen: (previous, current) =>
              current is NewOrderReceived || current is OrderRemoved,
          builder: (context, state) {
            final cubit = context.read<DriverHomeCubit>();
            final incomingOrders = cubit.incomingOrders;

            if (incomingOrders.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: incomingOrders.length,
                itemBuilder: (context, index) {
                  final data = incomingOrders[index];
                  return InstantOrderCard(
                    key: ValueKey('order_${data.userId}_${data.expiresAt}'),
                    orderData: data,
                    onOrderProcessed: () => cubit.removeOrder(data.userId),
                  );
                },
              );
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Column(
                    children: [
                      Icon(
                        Icons.radar,
                        size: 50.sp,
                        color: theme.colorScheme.primary.withOpacity(0.5),
                      ),
                      verticalSpace(12),
                      Text(
                        'جاري البحث عن طلبات قريبة منك...',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
