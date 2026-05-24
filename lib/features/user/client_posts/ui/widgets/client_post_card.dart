import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_cubit.dart';
import '../../data/models/client_post_model.dart';

class ClientPostCard extends StatefulWidget {
  final ClientPostModel post;
  const ClientPostCard({super.key, required this.post});

  @override
  State<ClientPostCard> createState() => _ClientPostCardState();
}

class _ClientPostCardState extends State<ClientPostCard> {
  String _formatNumber(num number) {
    return number
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  bool isDeleting = false;

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28.sp),
            horizontalSpace(8),
            const Text('تأكيد الحذف'),
          ],
        ),
        content: const Text(
          'هل أنت متأكد أنك تريد حذف هذا الإعلان؟\nلا يمكن التراجع عن هذا الإجراء.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _deletePost();
            },
            child: Text(
              'نعم، احذف',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePost() async {
    setState(() => isDeleting = true);
    // final scaffoldMessenger = ScaffoldMessenger.of(context);

    final result = await context.read<ClientPostsCubit>().deletePost(
      widget.post.id,
    );

    // if (!mounted) return;

    result.when(
      success: (msg) {
        SnackBarHelper.showSuccess(context, msg);
        // setState(() => isDeleting = false);
      },
      failure: (error) {
        if (mounted) setState(() => isDeleting = false);
        SnackBarHelper.showError(context, error.getAllErrorMessages());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFinished = widget.post.finished == 1;
    final statusColor = isFinished ? Colors.green : theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.inventory_2_rounded,
                    color: statusColor,
                    size: 20.sp,
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.object ?? 'شحنة غير مسماة',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(4),
                      Text(
                        isFinished
                            ? 'مكتمل - تم التوصيل'
                            : 'مفتوح - بانتظار العروض',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                if (isDeleting)
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.error,
                      strokeWidth: 2.5,
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _confirmDelete,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.error.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: Theme.of(context).colorScheme.error,
                        size: 20.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Divider(height: 1, color: theme.colorScheme.outline.withOpacity(0.3)),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.trip_origin_rounded,
                      color: Colors.green,
                      size: 16.sp,
                    ),
                    Container(
                      width: 2.w,
                      height: 28.h,
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      color: Colors.grey.shade300,
                    ),
                    Icon(
                      Icons.location_on_rounded,
                      color: Theme.of(context).colorScheme.error,
                      size: 16.sp,
                    ),
                  ],
                ),
                horizontalSpace(12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.post.startGovernorate ?? 'غير محدد'} - ${widget.post.startLocationDetails ?? ''}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(26),
                      Text(
                        '${widget.post.endGovernorate ?? 'غير محدد'} - ${widget.post.endLocationDetails ?? ''}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.04),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 16.sp,
                        color: Colors.grey.shade600,
                      ),
                      horizontalSpace(6),
                      Flexible(
                        child: Text(
                          'أقصى موعد:\n${widget.post.lastDate ?? 'غير محدد'}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(8),

                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'نطاق السعر',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${_formatNumber(widget.post.minPrice ?? 0)} - ${_formatNumber(widget.post.maxPrice ?? 0)}',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
