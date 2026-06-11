import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/responsive/responsive_layout.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/state_handlers/app_dialogs.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/shipment_control_bar.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/shipment_dialogs_helper.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_state.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/driver_card_widget.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/screens/drivers_shimmer_loading.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/screens/empty_drivers_widget.dart';

class AvailableDriversScreen extends StatefulWidget {
  const AvailableDriversScreen({super.key});

  @override
  State<AvailableDriversScreen> createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet;

    return BlocProvider(
      create: (context) => getIt<AvailableDriversCubit>()..initEngine(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final shouldPop = await ShipmentDialogsHelper.showExitWarning(
            context,
          );
          if (shouldPop == true && context.mounted) Navigator.pop(context);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('السائقين المتاحين'),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                final shouldPop = await ShipmentDialogsHelper.showExitWarning(
                  context,
                );
                if (shouldPop == true && context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ),

          body: BlocConsumer<AvailableDriversCubit, AvailableDriversState>(
            listenWhen: (previous, current) =>
                current is ShowExtendDialog ||
                current is DeleteSuccess ||
                current is ExtendSuccess ||
                current is ShipmentExpired ||
                current is Error ||
                current is ActionError ||
                current is SendToDriverSuccess,
            listener: (context, state) {
              state.maybeWhen(
                actionError: (errorModel) {
                  AppDialogs.showErrorDialog(
                    context,
                    errorModel.getAllErrorMessages(),
                  );
                },
                error: (errorModel) {
                  AppDialogs.showErrorDialog(
                    context,
                    errorModel.getAllErrorMessages(),
                  );
                },
                sendToDriverSuccess: (message) {
                  SnackBarHelper.showSuccess(context, message);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.clientHomeScreen,
                    (route) => false,
                  );
                },
                deleteSuccess: () {
                  SnackBarHelper.showSuccess(context, 'تم حذف الطلب بنجاح');
                  context.pushNamedAndRemoveUntil(
                    Routes.clientHomeScreen,
                    predicate: (route) => false,
                  );
                },
                showExtendDialog: () => ShipmentDialogsHelper.showExtendDialog(
                  context,
                  context.read<AvailableDriversCubit>(),
                ),
                shipmentExpired: () {
                  SnackBarHelper.showError(
                    context,
                    'انتهى وقت الطلب، تم إيقاف البحث وحذف الطلب تلقائياً.',
                  );
                  context.pushNamedAndRemoveUntil(
                    Routes.clientHomeScreen,
                    predicate: (route) => false,
                  );
                },
                extendSuccess: () {
                  SnackBarHelper.showSuccess(
                    context,
                    'تم تمديد وقت البحث بنجاح',
                  );
                },
                orElse: () {},
              );
            },
            buildWhen: (previous, current) =>
                current is Loading ||
                current is Success ||
                current is Empty ||
                current is Error ||
                current is DeleteLoading,
            builder: (context, state) {
              return Column(
                children: [
                  Divider(
                    height: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  ShipmentControlBar(),
                  Divider(
                    height: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  Expanded(
                    child: state.maybeWhen(
                      loading: () => const DriversShimmerLoading(),
                      deleteLoading: () =>
                          const Center(child: CircularProgressIndicator()),
                      empty: () => EmptyDriversWidget(
                        onRetry: () =>
                            context.read<AvailableDriversCubit>().initEngine(),
                      ),

                   
                      success: (drivers) => isTablet
                          ? GridView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.r,
                                vertical: 32.h,
                              ),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                childAspectRatio: 1.05,
                              ),
                              itemCount: drivers.length,
                              itemBuilder: (context, index) =>
                                  DriverCardWidget(driver: drivers[index]),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.r,
                                vertical: 32.h,
                              ),
                              itemCount: drivers.length,
                              itemBuilder: (context, index) =>
                                  DriverCardWidget(driver: drivers[index]),
                            ),

                      error: (errorModel) => ErrorStateWidget(
                        message: errorModel.getAllErrorMessages(),
                        onRetry: () =>
                            context.read<AvailableDriversCubit>().initEngine(),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
