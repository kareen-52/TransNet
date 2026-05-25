import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/loading_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/profile/logic/client_profile_cubit.dart';
import 'package:graduation_progect/features/user/profile/logic/client_profile_state.dart';
import 'package:graduation_progect/features/user/profile/ui/widgets/profile_client_body.dart';


class ProfileClientScreen extends StatelessWidget {
  const ProfileClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClientProfileCubit>()..getProfileData(),
      child: Scaffold(
        extendBody: true,
        body: BlocListener<ClientProfileCubit, ClientProfileState>(
          listenWhen: (_, curr) => curr.maybeWhen(
            editSuccess: (_) => true,
            error: (_) => true,
            orElse: () => false,
          ),
          listener: (context, state) {
            state.maybeWhen(
              editSuccess: (message) {
                SnackBarHelper.showSuccess(context, message);
                context.read<ClientProfileCubit>().getProfileData();
              },
              error: (error) {
                SnackBarHelper.showError(
                    context, error.message ?? 'حدث خطأ ما');
              },
              orElse: () {},
            );
          },
          child: BlocBuilder<ClientProfileCubit, ClientProfileState>(
            buildWhen: (prev, curr) => curr.maybeWhen(
              editSuccess: (_) => false, // don't rebuild on edit — avoid flash
              orElse: () => true,
            ),
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const LoadingStateWidget(),
                success: (profileData) =>
                    ProfileClientBody(profileData: profileData),
                error: (error) => ErrorStateWidget(
                  message: error.message ?? 'فشل تحميل البيانات',
                  onRetry: () =>
                      context.read<ClientProfileCubit>().getProfileData(),
                ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}
