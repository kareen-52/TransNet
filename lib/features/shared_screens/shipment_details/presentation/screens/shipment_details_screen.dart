import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/cubit/shipment_details_cubit.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/cubit/shipment_details_state.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/screens/shipment_details_body.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/screens/shipment_details_error_view.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/screens/shipment_details_loading_view.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  final int shipmentId;

  const ShipmentDetailsScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => getIt<ShipmentDetailsCubit>()..load(shipmentId),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: isDark
              ? AppColors.darkBackground
              : AppColors.lightBackground,
  
          body: Builder(
            builder: (context) {
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<ShipmentDetailsCubit>().refresh(shipmentId),
                child: BlocBuilder<ShipmentDetailsCubit, ShipmentDetailsState>(
                  builder: (context, state) => state.maybeWhen(
                    loading: () => const ShipmentDetailsLoadingView(),
                    success: (data) => ShipmentDetailsBody(data: data),
                    error: (error) =>
                        ShipmentDetailsErrorView(message: error.message),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}