import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/loading_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_state.dart';
import 'package:graduation_progect/features/user/profile/ui/widgets/profile_client_body.dart';

class ProfileClientScreen extends StatelessWidget {
  const ProfileClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..getProfileData(),
      child: Scaffold(
        extendBody: true,
        body: BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              current is EditSuccess || current is Error,
          listener: (context, state) {
            state.maybeWhen(
              editSuccess: (message) {
                SnackBarHelper.showSuccess(context, message);
                context.read<ProfileCubit>().getProfileData();
              },
              error: (apiErrorModel) {
                SnackBarHelper.showError(
                  context,
                  apiErrorModel.message ?? "حدث خطأ ما",
                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(apiErrorModel.message ?? "حدث خطأ ما"),
                //     backgroundColor: Colors.red,
                //   ),
                // );
              },
              orElse: () {},
            );
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const LoadingStateWidget(),
                success: (profileData) =>
                    ProfileClientBody(profileData: profileData),
                error: (error) => ErrorStateWidget(
                  message: error.message ?? "فشل تحميل البيانات",
                  onRetry: () => context.read<ProfileCubit>().getProfileData(),
                ),
                // Center(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(error.message ?? "فشل تحميل البيانات"),
                //       TextButton(
                //         onPressed: () =>
                //             context.read<ProfileCubit>().getProfileData(),
                //         child: const Text("إعادة المحاولة"),
                //       ),
                //     ],
                //   ),
                // ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}
