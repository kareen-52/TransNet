import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/widgets/state_handlers/app_dialogs.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_state.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/screens/create_shipment_step1.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/screens/create_shipment_step2.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/screens/create_shipment_step3.dart';

class CreateShipmentStepper extends StatelessWidget {
  const CreateShipmentStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final shipmentToEdit =
        ModalRoute.of(context)?.settings.arguments as ShipmentModel?;
    final bool isEditMode = shipmentToEdit != null;

    return BlocProvider(
      create: (context) =>
          getIt<CreateShipmentCubit>()..getGovernorates(shipmentToEdit: shipmentToEdit),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditMode ? 'تعديل طلب الشحن' : 'إنشاء طلب شحن'),
        ),
        body: BlocConsumer<CreateShipmentCubit, CreateShipmentState>(
          listener: (context, state) {
            state.maybeWhen(
              submitSuccess: (message) {
                SnackBarHelper.showSuccess(context, message);
                final cubit = context.read<CreateShipmentCubit>();

                if (cubit.isEditMode) {
                  Navigator.pop(context, true);
                } else {
                  Navigator.pop(context, 'goToDrivers');
                }
              },
              
              submitError: (errorModel) {
                // SnackBarHelper.showError(context, errorModel.getAllErrorMessages());
                AppDialogs.showErrorDialog(
                  context,
                  errorModel.getAllErrorMessages(),
                );
              },

              govError: (errorModel) {
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(
                //       errorModel.getAllErrorMessages(),
                //       style: Theme.of(context).textTheme.labelMedium!.copyWith(
                //         color: Theme.of(context).colorScheme.onPrimary,
                //       ),
                //     ),
                //     backgroundColor: Theme.of(context).colorScheme.error,
                //   ),
                // );
                AppDialogs.showErrorDialog(
                  context,
                  errorModel.getAllErrorMessages(),
                );
              },

              orElse: () {},
            );
          },

          builder: (context, state) {
            final cubit = context.read<CreateShipmentCubit>();

            bool isGovLoading = state.maybeWhen(
              govLoading: () => cubit.governorates.isEmpty,
              orElse: () => false,
            );

            if (isGovLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stepper(
              type: StepperType.horizontal,
              currentStep: cubit.currentStep,
              elevation: 0,
              controlsBuilder: (context, details) {
                return const SizedBox.shrink();
              },
              stepIconBuilder: (stepIndex, stepState) {
                return Container(
                  decoration: BoxDecoration(
                    color: stepIndex <= cubit.currentStep
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: stepState == StepState.complete
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 16.sp,
                          )
                        : Text(
                            '${stepIndex + 1}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16.sp,
                            ),
                          ),
                  ),
                );
              },
              steps: [
                Step(
                  title: const SizedBox.shrink(),
                  label: Text(
                    'المواقع',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  content: Step1Locations(cubit: cubit),
                  isActive: cubit.currentStep >= 0,
                  state: cubit.currentStep > 0
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const SizedBox.shrink(),
                  label: Text(
                    'التفاصيل',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  content: Step2Details(cubit: cubit),
                  isActive: cubit.currentStep >= 1,
                  state: cubit.currentStep > 1
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: const SizedBox.shrink(),
                  label: Text(
                    'المراجعة',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  content: Step3Review(cubit: cubit, state: state),
                  isActive: cubit.currentStep >= 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // void _showErrorDialog(BuildContext context, String errorMsg) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Row(
  //         children: [
  //           Icon(
  //             Icons.error_outline,
  //             color: Theme.of(context).colorScheme.error,
  //           ),
  //           horizontalSpace(8),
  //           const Text('تنبيه'),
  //         ],
  //       ),
  //       content: Text(errorMsg),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('حسناً'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
