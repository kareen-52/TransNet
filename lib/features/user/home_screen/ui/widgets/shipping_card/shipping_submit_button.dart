import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/shipment_model.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/shipment_navigation_helper.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_cubit.dart';
import 'package:graduation_progect/features/user/home_screen/logic/home_state.dart';
import '../../../../../../core/widgets/app_text_button.dart';

class ShippingSubmitButton extends StatelessWidget {
  const ShippingSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.maybeWhen(
          error: (errorModel) => AppTextButton(
            text: 'فشل الاتصال، أعد المحاولة',
            backgroundColor: theme.colorScheme.outline,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeightHelper.bold,
            ),
            prefixIcon: Icon(
              Icons.refresh,
              size: 25.sp,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            onPressed: () => context.read<HomeCubit>().checkActiveShipment(),
          ),

          loading: () => AppTextButton(
            text: 'جاري التحقق...',
            backgroundColor: theme.colorScheme.secondary,
            isLoading: true,
            onPressed: () {},
          ),

          hasActiveShipment: (shipment) => AppTextButton(
            text: 'لديك طلب قيد البحث',
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeightHelper.extraBold,
            ),
            prefixIcon: Icon(
              Icons.radar,
              size: 25.sp,
              color: theme.colorScheme.secondary,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.availableDriversScreen,
                arguments: shipment,
              ).then((_) {
                if (context.mounted)
                  context.read<HomeCubit>().checkActiveShipment();
              });
            },
          ),

          noActiveShipment: () => AppTextButton(
            text: 'بدء طلب شحن جديد',
            backgroundColor: theme.colorScheme.secondary,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeightHelper.extraBold,
            ),
            prefixIcon: Icon(Icons.add_circle_outline_outlined, size: 25.sp),
            onPressed: () {
              ShipmentNavigationHelper.openStepperAndHandleResult(
                context,
                context.read<HomeCubit>(),
              );
            },
          ),

          waitingForDriver: (shipment) =>
              _WaitingForDriverButton(shipment: shipment),

          cancelDriverLoading: () => AppTextButton(
            text: 'جاري التحقق...',
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
            isLoading: true,
            onPressed: () {},
          ),


          

          orElse: () => AppTextButton(
            text: 'بدء طلب شحن جديد',
            backgroundColor: theme.colorScheme.secondary,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeightHelper.extraBold,
            ),
            prefixIcon: Icon(Icons.add_circle_outline_outlined, size: 25.sp),
            onPressed: () {
              ShipmentNavigationHelper.openStepperAndHandleResult(
                context,
                context.read<HomeCubit>(),
              );
            },
          ),
        );
      },
    );
  }
}

class _WaitingForDriverButton extends StatefulWidget {
  final ShipmentModel shipment;
  const _WaitingForDriverButton({required this.shipment});

  @override
  State<_WaitingForDriverButton> createState() =>
      _WaitingForDriverButtonState();
}

class _WaitingForDriverButtonState extends State<_WaitingForDriverButton> {
  Timer? _timer;
  String _remaining = '';
  late DateTime _expiryUtc;

  @override
  void initState() {
    super.initState();
    _expiryUtc = DateTime.parse(widget.shipment.driver!.expiresAt).toUtc();
    _updateRemaining();
    _startTimer();
  }

  void _updateRemaining() {
    final diff = _expiryUtc.difference(DateTime.now().toUtc());
    if (diff.isNegative || diff.inSeconds <= 0) {
      _remaining = 'انتهى الوقت';
      _timer?.cancel();
      if (mounted) context.read<HomeCubit>().refreshQuietly();
    } else {
      final m = diff.inMinutes.remainder(60).toString().padLeft(2, '0');
      final s = diff.inSeconds.remainder(60).toString().padLeft(2, '0');
      _remaining = '$m:$s';
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(_updateRemaining);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showPendingDialog() {
    final driverName =
        '${widget.shipment.driver!.firstName} ${widget.shipment.driver!.lastName}';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('طلب قيد الانتظار'),
        content: Text(
          'لديك طلب مرسل إلى السائق $driverName ولم يرد بعد.\n'
          'يمكنك إلغاء الطلب لإرساله إلى سائق آخر.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('متابعة'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showCancelConfirmation();
            },
            child: const Text('إلغاء الطلب'),
          ),
        ],
      ),
    );
  }


  void _showCancelConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد الإلغاء'),
        content: const Text('هل أنت متأكد من إلغاء الطلب لهذا السائق؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<HomeCubit>().cancelRequestForDriver(
                widget.shipment.driver!.driverId,
              );
            },
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        state.maybeWhen(
          cancelDriverSuccess: (message) {
            SnackBarHelper.showSuccess(context, message);
          },
         
          error: (errorModel) {
            SnackBarHelper.showError(context, errorModel.getAllErrorMessages());
          },
          orElse: () {},
        );
      },
      child: AppTextButton(
        text: 'بانتظار رد السائق ($_remaining)',
        backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
        borderSide: BorderSide(color: theme.colorScheme.secondary),
        textStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeightHelper.extraBold,
        ),
        prefixIcon: Icon(
          Icons.hourglass_bottom,
          size: 25.sp,
          color: theme.colorScheme.secondary,
        ),
        onPressed: _showPendingDialog,
      ),
    );
  }
}
