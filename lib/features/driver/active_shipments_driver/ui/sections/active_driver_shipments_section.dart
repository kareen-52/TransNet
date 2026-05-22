import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/logic/active_driver_shipments_state.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/ui/widgets/active_driver_shipment_card.dart';
import 'package:graduation_progect/features/driver/active_shipments_driver/ui/widgets/active_driver_shipments_shimmer.dart';

class ActiveDriverShipmentsSection extends StatelessWidget {
  const ActiveDriverShipmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ActiveDriverShipmentsCubit, ActiveDriverShipmentsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),

          loading: () => _buildWithTitle(
            theme: theme,
            child: const ActiveDriverShipmentsShimmer(),
          ),

          empty: () => const SizedBox.shrink(),

          loaded: (shipments) => _buildWithTitle(
            theme: theme,
            child: SizedBox(
              height: 210.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: shipments.length,
                itemBuilder: (context, index) =>
                    ActiveDriverShipmentCard(shipment: shipments[index]),
              ),
            ),
          ),

          error: (error) => _buildWithTitle(
            theme: theme,
            child: ErrorStateWidget(
              message: error.getAllErrorMessages(),
              onRetry: () {
                context.read<ActiveDriverShipmentsCubit>().fetch();
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildWithTitle({required ThemeData theme, required Widget child}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'شحناتك النشطة',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(12),
          child,
        ],
      ),
    );
  }
}
