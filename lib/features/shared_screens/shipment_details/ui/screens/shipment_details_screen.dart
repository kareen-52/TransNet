import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/logic/shipment_details_cubit.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/logic/shipment_details_state.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/ui/widgets/shipment_details_content.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  final int shipmentId;

  const ShipmentDetailsScreen({super.key, required this.shipmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShipmentDetailsCubit>()..loadShipmentDetails(shipmentId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('تفاصيل الشحنة', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: BlocBuilder<ShipmentDetailsCubit, ShipmentDetailsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (data) => ShipmentDetailsContent(data: data),
              error: (error) => Center(
                child: Text(
                  error.message ?? 'حدث خطأ',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}