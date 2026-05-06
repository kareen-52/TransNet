import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/user/available_drivers/data/models/driver_model.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_state.dart';

class DriverCardFooter extends StatefulWidget {
  final DriverModel driver;

  const DriverCardFooter({super.key, required this.driver});

  @override
  State<DriverCardFooter> createState() => _DriverCardFooterState();
}

class _DriverCardFooterState extends State<DriverCardFooter> {
  // bool _isLoading = false;

  String _formatPrice(double price) {
    return price.round().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تكلفة التوصيل', style: theme.textTheme.bodySmall),
              Text(
                '${_formatPrice(widget.driver.price)} ل.س',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeightHelper.extraBold,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
        horizontalSpace(16),
        Expanded(
          flex: 1,
          child: BlocBuilder<AvailableDriversCubit, AvailableDriversState>(
            builder: (context, state) {
              bool isLoading = state is SendToDriverLoading;
              return AppTextButton(
                isLoading: isLoading,
                text: 'اختيار السائق',
                backgroundColor: theme.colorScheme.secondary,
                onPressed: isLoading
                    ? null
                    : () => context.read<AvailableDriversCubit>().sendToDriver(widget.driver,),
              );
            },
          ),
        ),
      ],
    );
  }
}
