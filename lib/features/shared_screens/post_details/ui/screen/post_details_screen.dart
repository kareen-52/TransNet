import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/apply_to_post/logic/apply_to_post_cubit.dart';
import 'package:graduation_progect/features/driver/apply_to_post/ui/apply_post_bottom_sheet.dart';
import 'package:graduation_progect/features/shared_screens/post_details/data/models/post_details_model.dart';
import 'package:graduation_progect/features/shared_screens/post_details/ui/screen/post_details_shimmer.dart';
import 'package:graduation_progect/features/shared_screens/post_details/ui/widgets/post_location_card.dart';
import 'package:graduation_progect/features/shared_screens/post_details/ui/widgets/post_price_info_card.dart';
import 'package:graduation_progect/features/user/active_orders/logic/active_orders_cubit.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_cubit.dart';
import '../../logic/post_details_cubit.dart';
import '../../logic/post_details_state.dart';
import '../widgets/post_cargo_card.dart';
import '../widgets/post_driver_offer_card.dart';


class PostDetailsScreen extends StatelessWidget {
  final int postId;
  const PostDetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => getIt<PostDetailsCubit>()..getPostDetails(postId),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(title: const Text('تفاصيل الإعلان'), centerTitle: true),
        body: BlocConsumer<PostDetailsCubit, PostDetailsState>(
          listener: (context, state) {
            state.whenOrNull(
              acceptSuccess: (msg) {
                SnackBarHelper.showSuccess(context, msg);
                Navigator.pop(context);
                try {
                  getIt<ClientPostsCubit>().fetchMyPosts();
                  getIt<ActiveOrdersCubit>().silentRefresh();
                } catch (_) {}
              },
              acceptError: (err) {
                SnackBarHelper.showError(context, err.getAllErrorMessages());
              },
            );
          },
          buildWhen: (previous, current) {
            return current.maybeWhen(
              acceptSuccess: (_) => false,
              acceptError: (_) => false,
              orElse: () => true,
            );
          },
          builder: (context, state) {
            final cubit = context.read<PostDetailsCubit>();
            final data = cubit.currentPostDetails;

            if (data != null) {
              return _buildSuccessContent(context, data, state);
            }

            return state.maybeWhen(
              initial: () => const PostDetailsShimmer(),
              loading: () => const PostDetailsShimmer(),
              error: (errorModel) {
                final String errorMsg = errorModel.getAllErrorMessages().toLowerCase();
                
                final bool isDeletedPost = errorModel.code == 404 || 
                                           errorMsg.contains('no query results') || 
                                           errorMsg.contains('not found');

                if (isDeletedPost) {
                  return _buildDeletedPostView(context);
                }

                return ErrorStateWidget(
                  message: errorModel.getAllErrorMessages(),
                  onRetry: () => cubit.getPostDetails(postId),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDeletedPostView(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.content_paste_off_rounded,
                size: 64.sp,
                color: theme.colorScheme.onSurface.withOpacity(0.4),
              ),
            ),
            verticalSpace(24),
            Text(
              'الإعلان غير متاح',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            verticalSpace(12),
            Text(
              'عذراً، يبدو أن هذا الإعلان قد تم حذفه ولم يعد متاحاً.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(40),
            SizedBox(
              width: 200.w,
              child: AppTextButton(
                text: 'العودة للخلف',
                backgroundColor: theme.colorScheme.primary,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context, PostDetailsModel data, PostDetailsState state) {
    final loadingDriverId = state.maybeWhen(
      acceptLoading: (id) => id,
      orElse: () => null,
    );

    final bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h + bottomSafeArea),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusBanner(context, data),
          verticalSpace(24),

          _buildSectionTitle(context, 'تفاصيل الشحنة'),
          verticalSpace(8),
          PostCargoCard(post: data),
          verticalSpace(24),

          _buildSectionTitle(context, 'مواقع التسليم'),
          verticalSpace(8),
          PostLocationsCard(post: data),
          verticalSpace(24),

          _buildSectionTitle(context, 'معلومات التسعير'),
          verticalSpace(8),
          PostPriceInfoCard(post: data),
          verticalSpace(32),

          FutureBuilder<String>(
            future: Future.value(SharedPrefHelper.getString(SharedPrefKeys.userRole)),
            builder: (context, snapshot) {
              final isClient = snapshot.hasData && snapshot.data == 'client';
              final isDriver = snapshot.hasData && snapshot.data == 'driver';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.drivers != null && data.drivers!.isNotEmpty) ...[
                    _buildDriversSectionHeader(context, data),
                    verticalSpace(12),
                    ...data.drivers!.map((d) {
                      final isThisLoading = loadingDriverId == d.id;
                      final isAnyLoading = loadingDriverId != null;

                      return PostDriverOfferCard(
                        driver: d,
                        isFinished: data.isFinished,
                        isClient: isClient,
                        isLoading: isThisLoading,
                        onAccept: isAnyLoading
                            ? null
                            : () => context.read<PostDetailsCubit>().acceptDriverOffer(data.id, d.id),
                      );
                    }).toList(),
                  ] else if (data.drivers != null && data.drivers!.isEmpty && !data.isFinished) ...[
                    _buildEmptyDriversState(context),
                  ],

                  if (!data.isFinished && isDriver && data.drivers == null) ...[
                    AppTextButton(
                      text: 'تقديم عرض على الإعلان',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => BlocProvider(
                            create: (context) => getIt<ApplyToPostCubit>(),
                            child: ApplyPostBottomSheet(
                              postId: data.id,
                              minPrice: data.minPrice ?? 0,
                              maxPrice: data.maxPrice ?? 0,
                              lastDate: data.lastDate ?? DateTime.now().add(const Duration(days: 30)).toString().split(' ')[0],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, PostDetailsModel data) {
    final theme = Theme.of(context);
    final isFinished = data.isFinished;
    final statusColor = isFinished ? Colors.green : theme.colorScheme.primary;
    final statusText = isFinished ? 'منتهي' : 'مفتوح - بانتظار العروض';
    final statusIcon = isFinished ? Icons.check_circle_rounded : Icons.pending_rounded;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(statusIcon, color: statusColor, size: 20.sp),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حالة الإعلان',
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                ),
                verticalSpace(2),
                Text(
                  statusText,
                  style: theme.textTheme.titleSmall?.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
    );
  }

  Widget _buildDriversSectionHeader(BuildContext context, PostDetailsModel data) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data.isFinished ? 'السائقون المتقدمون' : 'عروض السائقين',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '${data.drivers!.length} ${data.isFinished ? 'سائق' : 'عروض'}',
            style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyDriversState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Icon(Icons.hourglass_empty_rounded, color: theme.colorScheme.onSurface.withOpacity(0.7), size: 48.sp),
            verticalSpace(8),
            Text(
              'بانتظار تقديم عروض من السائقين...',
              style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}