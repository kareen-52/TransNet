import 'package:flutter/material.dart';
import '../../data/models/vehicle_type_model.dart';
import 'transport_item_card.dart';

class TransportGrid extends StatelessWidget {
  final List<VehicleTypeModel> methods;
  final int crossAxisCount;

  const TransportGrid({super.key, required this.methods, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.15,
      ),
      itemCount: methods.length,
      itemBuilder: (context, index) {
        return TransportItemCard(vehicle: methods[index]);
      },
    );
  }
}