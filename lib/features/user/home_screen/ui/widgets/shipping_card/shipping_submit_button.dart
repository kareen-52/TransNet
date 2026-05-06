import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
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
              // color: Colors.white,
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
            // backgroundColor: theme.colorScheme.error.withOpacity(0.9),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              // width: 2,
            ),
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
            // backgroundColor: AppColors.success,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              // color: theme.colorScheme.surface,
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
