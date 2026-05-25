import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_state.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/shipment_dialogs_helper.dart';

class ShipmentControlBar extends StatelessWidget {
  const ShipmentControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),

      child: BlocBuilder<AvailableDriversCubit, AvailableDriversState>(
        buildWhen: (previous, current) =>
            current is ShowExtendDialog ||
            current is ExtendSuccess ||
            current is Loading ||
            current is Error,
        builder: (context, state) {
          final cubit = context.read<AvailableDriversCubit>();

          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.w,
            runSpacing: 4.h,
            children: [
            
              TextButton.icon(
                onPressed: () async {
                  final cubit = context.read<AvailableDriversCubit>();
                  if (cubit.currentShipment != null) {
                    final didUpdate = await Navigator.pushNamed(
                      context,
                      Routes.createShipment,
                      arguments: cubit.currentShipment,
                    );
                    if (didUpdate == true && context.mounted) cubit.initEngine();
                  }
                },
                icon: Icon(Icons.edit, size: 20.sp),
                label: const Text('تعديل بيانات الشحنة'),
                style: TextButton.styleFrom(

                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),


              TextButton.icon(
                onPressed: () => ShipmentDialogsHelper.confirmDelete(
                  context,
                  context.read<AvailableDriversCubit>(),
                ),
                icon: Icon(Icons.delete_outline, size: 20.sp),
                label: const Text('حذف الشحنة'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,


                ),
              ),


              if (cubit.isExpirationWarningActive)
                TextButton.icon(
                  onPressed: () => cubit.extendShipmentTime(),
                  icon: Icon(Icons.timer_sharp, size: 20.sp),
                  label: const Text('تمديد وقت البحث'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),

                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
