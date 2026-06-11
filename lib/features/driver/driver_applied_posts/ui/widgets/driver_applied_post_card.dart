import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/driver/apply_to_post/logic/apply_to_post_cubit.dart';
import 'package:graduation_progect/features/driver/apply_to_post/ui/apply_post_bottom_sheet.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';
import '../../logic/driver_applied_posts_cubit.dart';

class DriverAppliedPostCard extends StatefulWidget {
  final PostModel post;
  const DriverAppliedPostCard({super.key, required this.post});

  @override
  State<DriverAppliedPostCard> createState() => _DriverAppliedPostCardState();
}

class _DriverAppliedPostCardState extends State<DriverAppliedPostCard> {
  bool isDeleting = false;

  String _formatNumber(num number) {
    return number
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  void _confirmDelete() {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: theme.colorScheme.error,
              size: 28.sp,
            ),
            horizontalSpace(8),
            const Text('إلغاء العرض'),
          ],
        ),
        content: const Text(
          'هل أنت متأكد أنك تريد إلغاء عرضك على هذا الإعلان؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _cancelOffer();
            },
            child: Text(
              'نعم، إلغاء',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelOffer() async {
    setState(() => isDeleting = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final result = await context.read<DriverAppliedPostsCubit>().cancelOffer(
      widget.post.id,
    );
    if (!mounted) return;

    result.when(
      success: (msg) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.white),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      failure: (error) {
        setState(() => isDeleting = false);
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    error.getAllErrorMessages(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  void _showPostDetailsDialog() {
    final theme = Theme.of(context);
    final post = widget.post;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تفاصيل الشحنة',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
                  ),
                ],
              ),
              Divider(color: theme.colorScheme.outline.withOpacity(0.7)),

              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(12),


                      _buildSectionTitle(
                        theme,
                        'المعلومات المالية والزمنية',
                      ),
                      _buildInfoRow(
                        theme,
                        'ميزانية العميل:',
                        '${_formatNumber(post.minPrice ?? 0)} - ${_formatNumber(post.maxPrice ?? 0)} ل.س',
                      ),
                      _buildInfoRow(
                        theme,
                        'آخر موعد للتقديم:',
                        post.lastDate ?? 'غير محدد',
                      ),
                      _buildInfoRow(
                        theme,
                        'تاريخ الإنشاء:',
                        post.createdAt?.split('T')[0] ?? 'غير محدد',
                      ),

                      verticalSpace(8),
                      Divider(color: theme.colorScheme.outline.withOpacity(0.7)),
                      verticalSpace(8),


                      _buildSectionTitle(
                        theme,
                        'تفاصيل الغرض',
                      ),
                      _buildInfoRow(
                        theme,
                        'محتوى الشحنة:',
                        post.object ?? 'غير محدد',
                      ),
                     
                      verticalSpace(8),

                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: theme.colorScheme.outline.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildDimensionItem(
                              theme,
                              'الوزن',
                              '${double.tryParse(post.weight ?? '0')?.toStringAsFixed(1)} كغ',
                            ),
                            _buildDimensionItem(
                              theme,
                              'الطول',
                              '${double.tryParse(post.length ?? '0')?.toStringAsFixed(1)} سم',
                            ),
                            _buildDimensionItem(
                              theme,
                              'العرض',
                              '${double.tryParse(post.width ?? '0')?.toStringAsFixed(1)} سم',
                            ),
                            _buildDimensionItem(
                              theme,
                              'الارتفاع',
                              '${double.tryParse(post.height ?? '0')?.toStringAsFixed(1)} سم',
                            ),
                          ],
                        ),
                      ),

                      verticalSpace(8),
                      Divider(color: theme.colorScheme.outline.withOpacity(0.7)),
                      verticalSpace(8),


                      _buildSectionTitle(
                        theme,
                        'مسار الشحنة',
                      ),
                      _buildLocationDetail(
                        theme,
                        'من:',
                        '${post.startGovernorate ?? ''} - ${post.startLocationDetails ?? ''}',
                        Colors.green,
                      ),
                      verticalSpace(8),
                      _buildLocationDetail(
                        theme,
                        'إلى:',
                        '${post.endGovernorate ?? ''} - ${post.endLocationDetails ?? ''}',
                        theme.colorScheme.error,
                      ),

                      verticalSpace(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    ThemeData theme,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          horizontalSpace(8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor ?? theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionItem(ThemeData theme, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        verticalSpace(4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationDetail(
    ThemeData theme,
    String label,
    String value,
    Color dotColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Icon(Icons.circle, size: 12.sp, color: dotColor),
        ),
        horizontalSpace(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFinished = widget.post.finished == 1;

    return GestureDetector(
      onTap: _showPostDetailsDialog,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.15),
          ),
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
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.inventory_2_rounded,
                      color: theme.colorScheme.primary,
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
                              ? 'عذراً، الإعلان مغلق'
                              : 'قيد انتظار رد العميل',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isFinished
                                ? theme.colorScheme.error
                                : theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),
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
                        color: theme.colorScheme.error,
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.04),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تاريخ توصيلك',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          verticalSpace(4),
                          Text(
                            widget.post.myDate ?? '-',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'سعرك المقدم',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                          ),
                          verticalSpace(4),
                          Text(
                            '${_formatNumber(widget.post.myPrice ?? 0)} ل.س',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (!isFinished) ...[
                    verticalSpace(16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppTextButton(
                            text: 'تعديل عرضي',
                            height: 44.h,
                            textStyle: TextStyle(
                              fontSize: 13.sp,
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                            borderSide: BorderSide(
                              color: theme.colorScheme.primary,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => BlocProvider(
                                  create: (context) =>
                                      getIt<ApplyToPostCubit>(),
                                  child: ApplyPostBottomSheet(
                                    postId: widget.post.id,
                                    minPrice: widget.post.minPrice ?? 0,
                                    maxPrice: widget.post.maxPrice ?? 0,
                                    lastDate:
                                        widget.post.lastDate ??
                                        DateTime.now()
                                            .add(const Duration(days: 30))
                                            .toString()
                                            .split(' ')[0],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        horizontalSpace(8),
                        Expanded(
                          flex: 1,
                          child: isDeleting
                              ? Center(
                                  child: CircularProgressIndicator(color: theme.colorScheme.error,),
                                )
                              : AppTextButton(
                                  height: 44.h,
                                  textStyle: TextStyle(
                                    fontSize: 13.sp,
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  onPressed: _confirmDelete,
                                  text: 'إلغاء',
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
