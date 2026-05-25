import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/features/shared_screens/map/data/map_constants.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step1/location_section.dart';
import 'package:latlong2/latlong.dart';

class Step1Locations extends StatelessWidget {
  final CreateShipmentCubit cubit;
  const Step1Locations({super.key, required this.cubit});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocationSection(
          title: 'من أين',
          govValue: cubit.startGovernorate,
          onChanged: (val) => cubit.changeStartGovernorate(val),
          onMapTap: () => _openMap(context, true),
          hasLocation: cubit.startLat != null,
          governorates: cubit.governorates,
        ),

        verticalSpace(24),
        LocationSection(
          title: 'إلى أين',
          govValue: cubit.endGovernorate,
          onChanged: (val) => cubit.changeEndGovernorate(val),
          onMapTap: () => _openMap(context, false),
          hasLocation: cubit.endLat != null,
          governorates: cubit.governorates,
        ),

        verticalSpace(40),
        AppTextButton(
          text: 'التالي',
          backgroundColor: theme.colorScheme.secondary,
          onPressed: cubit.nextStep,
        ),
        verticalSpace(32),
      ],
    );
  }

  void _openMap(BuildContext context, bool isStart) async {
    final selectedGov = isStart ? cubit.startGovernorate : cubit.endGovernorate;

    if (selectedGov == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'الرجاء اختيار المحافظة أولاً',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final govData = MapConstants.governorateData[selectedGov.id];
    final LatLng center = govData?['center'] ?? const LatLng(33.5138, 36.2765);
    final LatLngBounds bounds =
        govData?['bounds'] ??
        LatLngBounds(const LatLng(32.0, 35.0), const LatLng(37.5, 42.5));

    LatLng initialLoc;
    if (isStart && cubit.startLat != null) {
      initialLoc = LatLng(cubit.startLat!, cubit.startLng!);
    } else if (!isStart && cubit.endLat != null) {
      initialLoc = LatLng(cubit.endLat!, cubit.endLng!);
    } else {
      initialLoc = center;
    }

    final result = await context.pushNamed(
      Routes.mapScreen,
      arguments: {
        'title': isStart ? 'موقع الانطلاق' : 'موقع الوصول',
        'initialLocation': initialLoc,
        'governorateName': selectedGov.name,
        'governorateBounds': bounds,
      },
    );

    if (result != null && result is LatLng) {
      cubit.updateLocation(isStart, result.latitude, result.longitude);
    }
  }
}
