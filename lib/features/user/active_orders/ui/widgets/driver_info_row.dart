import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/active_orders/data/models/active_order_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> callDriver(BuildContext context, String phone) async {
  final uri = Uri.parse('tel:$phone');
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      SnackBarHelper.showError(context, 'لا يمكن فتح تطبيق الهاتف');
    }
  } catch (e) {
    SnackBarHelper.showError(context, 'حدث خطأ أثناء محاولة الاتصال');
  }
}

class DriverInfoRow extends StatelessWidget {
  final ActiveOrderDriverModel driver;

  const DriverInfoRow({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fullName = '${driver.firstName} ${driver.lastName}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person_rounded,
                  color: theme.colorScheme.primary,
                  size: 24.sp,
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: fullName,
                  child: Text(
                    fullName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: theme.colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
        horizontalSpace(8),
        GestureDetector(
          onTap: () => callDriver(context, driver.phoneNumber),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.phone_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 16.sp,
                ),
                horizontalSpace(6),
                Text(
                  'اتصال',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
