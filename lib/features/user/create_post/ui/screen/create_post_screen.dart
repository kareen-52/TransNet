import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/widgets/state_handlers/app_dialogs.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_state.dart';
import '../widgets/price_adjustment_bottom_sheet.dart';
import '../widgets/step1_post_locations.dart';
import '../widgets/step2_post_details.dart';
import '../widgets/step3_post_review.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreatePostCubit>()..getGovernorates(),
      child: Scaffold(
        appBar: AppBar(title: const Text('إنشاء إعلان جديد')),
        body: BlocConsumer<CreatePostCubit, CreatePostState>(
          listener: (context, state) {
            state.maybeWhen(
              stepOneSuccess: (post, msg) async {
                SnackBarHelper.showSuccess(context, msg);
                final bool? isPublished = await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (context) => getIt<CreatePostCubit>(),
                      child: PriceAdjustmentScreen(post: post),
                    ),
                  ),
                );

                // ✅ إذا عادت الشاشة بنجاح، نغلق شاشة النموذج أيضاً!
                if (isPublished == true && context.mounted) {
                  Navigator.pop(context, true);
                }
              },
              submitError: (err) => AppDialogs.showErrorDialog(
                context,
                err.getAllErrorMessages(),
              ),
              govError: (err) => AppDialogs.showErrorDialog(
                context,
                err.getAllErrorMessages(),
              ),
              orElse: () {},
            );
          },
          builder: (context, state) {
            final cubit = context.read<CreatePostCubit>();

            if (cubit.governorates.isEmpty)
              return const Center(child: CircularProgressIndicator());

            return Stepper(
              type: StepperType.horizontal,
              currentStep: cubit.currentStep,
              elevation: 0,
              controlsBuilder: (context, details) => const SizedBox.shrink(),
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
                  content: Step1PostLocations(cubit: cubit),
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
                  content: Step2PostDetails(cubit: cubit),
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
                  content: Step3PostReview(cubit: cubit, state: state),
                  isActive: cubit.currentStep >= 2,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
