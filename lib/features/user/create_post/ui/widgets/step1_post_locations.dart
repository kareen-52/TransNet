import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/features/shared_screens/map/data/map_constants.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step1/location_section.dart';
import 'package:latlong2/latlong.dart';

class Step1PostLocations extends StatelessWidget {
  final CreatePostCubit cubit;
  const Step1PostLocations({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: cubit.formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationSection(
            title: 'موقع الاستلام (البداية)',
            govValue: cubit.startGovernorate,
            governorates: cubit.governorates,
            onChanged: (val) => cubit.changeStartGovernorate(val),
            onMapTap: () => _openMap(context, true),
            hasLocation: cubit.startLat != null,
          ),
          verticalSpace(12),
          AppTextFormField(
            controller: cubit.startDetailsCtrl,
            hintText: 'تفاصيل العنوان (مثال: جرمانا، ساحة الروضة)',
            validator: (v) => v!.isEmpty ? 'التفاصيل مطلوبة' : null,
          ),
          
          verticalSpace(32),

          LocationSection(
            title: 'موقع التسليم (النهاية)',
            govValue: cubit.endGovernorate,
            governorates: cubit.governorates,
            onChanged: (val) => cubit.changeEndGovernorate(val),
            onMapTap: () => _openMap(context, false),
            hasLocation: cubit.endLat != null,
          ),
          verticalSpace(12),
          AppTextFormField(
            controller: cubit.endDetailsCtrl,
            hintText: 'تفاصيل العنوان (مثال: القصاع، مقابل المشفى)',
            validator: (v) => v!.isEmpty ? 'التفاصيل مطلوبة' : null,
          ),

          verticalSpace(40),
          AppTextButton(
            text: 'التالي',
            backgroundColor: theme.colorScheme.secondary,
            onPressed: cubit.nextStep,
          ),
          verticalSpace(32),
        ],
      ),
    );
  }

  // دالة الخريطة المنسوخة والمعدلة
  void _openMap(BuildContext context, bool isStart) async {
    final selectedGov = isStart ? cubit.startGovernorate : cubit.endGovernorate;
    if (selectedGov == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرجاء اختيار المحافظة أولاً'), backgroundColor: Colors.red));
      return;
    }

    final govData = MapConstants.governorateData[selectedGov.id];
    final LatLng initialLoc = (isStart && cubit.startLat != null)
        ? LatLng(cubit.startLat!, cubit.startLng!)
        : (!isStart && cubit.endLat != null)
            ? LatLng(cubit.endLat!, cubit.endLng!)
            : govData?['center'] ?? const LatLng(33.5138, 36.2765);

    final result = await context.pushNamed(Routes.mapScreen, arguments: {
      'title': isStart ? 'موقع الانطلاق' : 'موقع الوصول',
      'initialLocation': initialLoc,
      'governorateName': selectedGov.name,
      'governorateBounds': govData?['bounds'] ?? LatLngBounds(const LatLng(32.0, 35.0), const LatLng(37.5, 42.5)),
    });

    if (result != null && result is LatLng) {
      cubit.updateLocation(isStart, result.latitude, result.longitude);
    }
  }
}