import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/user/vehicle_types/logic/vehicle_types_cubit.dart';
import 'package:graduation_progect/features/user/vehicle_types/logic/vehicle_types_state.dart';
import 'package:graduation_progect/features/user/vehicle_types/ui/widgets/transport_grid.dart';
import 'package:graduation_progect/features/user/vehicle_types/ui/widgets/transport_grid_shimmer.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/responsive/responsive_layout.dart';

class TransportMethodsSection extends StatelessWidget {
  const TransportMethodsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'وسائل النقل المتاحة',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(12),

        BlocBuilder<VehicleTypesCubit, VehicleTypesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),

              loading: () => const TransportGridShimmer(),

              success: (vehicles) {
                if (vehicles.isEmpty) {
                  return EmptyStateWidget(
                    title: 'لا توجد وسائل نقل حالياً',
                    subTitle: 'نعمل على توفير وسائل نقل في منطقتك قريباً.',
                    onRetry: () =>
                        context.read<VehicleTypesCubit>().fetchVehicleTypes(),
                  );
                }
                return ResponsiveLayout(
                  mobile: TransportGrid(methods: vehicles, crossAxisCount: 2),
                  tablet: TransportGrid(methods: vehicles, crossAxisCount: 3),
                  desktop: TransportGrid(methods: vehicles, crossAxisCount: 4),
                );
              },

              error: (errorModel) => ErrorStateWidget(
                message: errorModel.getAllErrorMessages(),
                onRetry: () =>
                    context.read<VehicleTypesCubit>().fetchVehicleTypes(),
              ),
            );
          },
        ),
      ],
    );
  }
}
