import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/loading_state_widget.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_state.dart';
import 'package:graduation_progect/features/driver/profile/ui/widgets/profile_driver_body.dart';

class ProfileDriverScreen extends StatelessWidget {
  const ProfileDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocListener<ProfileCubit, ProfileState>(
        listenWhen: (previous, current) =>
            current is EditSuccess || current is Error,
        listener: (context, state) {
          state.maybeWhen(
            editSuccess: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.green),
              );
              context.read<ProfileCubit>().getProfileData();
            },
            error: (apiErrorModel) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(apiErrorModel.message ?? "حدث خطأ ما"),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const LoadingStateWidget(),
              success: (profileData) =>
                  ProfileDriverBody(profileData: profileData),
              error: (error) => ErrorStateWidget(
                message: error.message ?? "فشل تحميل البيانات",
                onRetry: () => context.read<ProfileCubit>().getProfileData(),
              ),
           
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
