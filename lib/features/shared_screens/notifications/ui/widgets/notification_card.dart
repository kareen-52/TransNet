import 'package:graduation_progect/core/notifications/notification_route_helper.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/shared_screens/notifications/data/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  IconData _getIconForTitle(String title) {
    if (title.contains('قبول')) return Icons.check_circle_outline;
    if (title.contains('رفض')) return Icons.cancel_outlined;
    if (title.contains('تأكيد') || title.contains('استلام')) return Icons.local_shipping_outlined;
    return Icons.notifications_active_outlined;
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString).toLocal();

      return DateFormat('yyyy/MM/dd - hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isUnread = notification.status == 0; //  0 = غير مقروء
    final icon = _getIconForTitle(notification.title);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: InkWell( 
        borderRadius: BorderRadius.circular(24.r),
        onTap: () {
          int extractedPostId = 0;
          if (notification.title.contains('إعلانات')) {
              extractedPostId = notification.postId ?? 0; 
          }

          NotificationRouteHelper.handleNotificationAction(
            context: context,
            title: notification.title,
            body: notification.message,
            shipmentId: notification.shipmentId ?? 0, 
            postId: extractedPostId,
            fullData: {},
          );
        },
        child: CustomShadowCard(
          backgroundColor: isUnread
              ? theme.colorScheme.surface
              : theme.colorScheme.surfaceVariant.withOpacity(0.4),
          padding: EdgeInsets.all(16.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 24.sp),
              ),
              horizontalSpace(12),
        
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: isUnread
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
        
                    Text(
                      notification.message,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                    verticalSpace(24),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        horizontalSpace(4),
                        Text(
                          _formatDate(notification.createdAt),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
