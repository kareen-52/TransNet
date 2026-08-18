import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/loading_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/driver_details/data/models/driver_details_model.dart';
import 'package:graduation_progect/features/user/driver_details/logic/driver_details_cubit.dart';
import 'package:graduation_progect/features/user/driver_details/logic/driver_details_state.dart';
import 'package:graduation_progect/features/user/available_drivers/ui/widgets/badge/driver_badge_widget.dart';
import 'package:flutter/services.dart';

class DriverDetailsBottomSheet extends StatelessWidget {
  final int driverId;
  final Uint8List? imageBytes;

  const DriverDetailsBottomSheet({
    super.key,
    required this.driverId,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          getIt<DriverDetailsCubit>()..fetchDriverDetails(driverId),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              verticalSpace(16),
              Text(
                'تفاصيل السائق',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
              verticalSpace(16),
          
              Expanded(
                child: BlocBuilder<DriverDetailsCubit, DriverDetailsState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => const Center(
                        child: SingleChildScrollView(child: LoadingStateWidget()),
                      ),
                      error: (errorModel) => SingleChildScrollView(
                        child: ErrorStateWidget(
                          message: errorModel.getAllErrorMessages(),
                          onRetry: () => context
                              .read<DriverDetailsCubit>()
                              .fetchDriverDetails(driverId),
                        ),
                      ),
                      success: (details) =>
                          _buildDetailsContent(context, details),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsContent(
    BuildContext context,
    DriverDetailsModel details,
  ) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          verticalSpace(8),

          Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: theme.colorScheme.surface,
                child: ClipOval(
                  child: imageBytes != null
                      ? Image.memory(
                          imageBytes!,
                          width: 110.r,
                          height: 110.r,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.person,
                          size: 40.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${details.user.firstName} ${details.user.lastName}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                    verticalSpace(4),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.warning, size: 20.sp),
                        horizontalSpace(4),
                        Text(
                          details.averageRate.toString(),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeightHelper.bold,
                          ),
                        ),
                        horizontalSpace(16),

                        DriverBadgeWidget(
                          badgeTitle: details.badge.name,
                          badgeDescription: details.badge.text,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(24),
          _buildCopyableRow(
            context: context,
            icon: Icons.badge_outlined,
            title: 'رقم المستخدم',
            value: details.user.userNumber,
          ),

          _buildCopyableRow(
            context: context,
            icon: Icons.phone_android,
            title: 'رقم الهاتف',
            value: details.user.phoneNumber,
          ),

          const Divider(),

          verticalSpace(24),

          Text(
            'معلومات المركبة',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          verticalSpace(12),
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  context,
                  Icons.local_shipping,
                  'النوع',
                  details.car.vehicleType.type,
                ),
                verticalSpace(4),
                Padding(
                  padding: EdgeInsets.only(right: 28.w),
                  child: Text(
                    details.car.vehicleType.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                verticalSpace(8),
                _buildInfoRow(
                  context,
                  Icons.branding_watermark,
                  'الشركة والموديل',
                  '${details.car.manufacturer} ${details.car.model} (${details.car.yearOfManufacture})',
                ),
                verticalSpace(8),
                _buildInfoRow(
                  context,
                  Icons.color_lens,
                  'اللون',
                  details.car.color,
                ),
                verticalSpace(8),
                _buildInfoRow(
                  context,
                  Icons.numbers,
                  'رقم اللوحة',
                  details.car.licensePlateNumber,
                ),
              ],
            ),
          ),
          verticalSpace(24),

          Text(
            'المحافظات التي يعمل بها',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          verticalSpace(12),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: details.driverGovernorates.map((gov) {
              return Chip(label: Text(gov.name));
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 20.sp,
        ),
        horizontalSpace(8),
        Text('$title: ', style: Theme.of(context).textTheme.bodyMedium),
        Expanded(
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeightHelper.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCopyableRow({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 20.sp),
        horizontalSpace(8),
        Text('$title: ', style: theme.textTheme.bodyMedium),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        const Spacer(),

        IconButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: value));
            if (context.mounted) {
              SnackBarHelper.showSuccess(context, 'تم نسخ $title بنجاح');
            }
          },
          icon: Icon(
            Icons.copy_rounded,
            color: theme.colorScheme.primary,
            size: 20.sp,
          ),
          tooltip: 'نسخ $title',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
