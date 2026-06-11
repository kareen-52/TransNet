import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/user/client_posts/ui/screen/posts_shimmer.dart';
import '../../logic/driver_applied_posts_cubit.dart';
import '../../logic/driver_applied_posts_state.dart';
import '../widgets/driver_applied_post_card.dart';

class AppliedPostsScreen extends StatelessWidget {
  const AppliedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: getIt<DriverAppliedPostsCubit>()..fetchAppliedPosts(),
      // create: (context) => getIt<DriverAppliedPostsCubit>()..fetchAppliedPosts(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: theme.scaffoldBackgroundColor,
      
        body: BlocBuilder<DriverAppliedPostsCubit, DriverAppliedPostsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const PostsShimmer(),
              loading: () => const PostsShimmer(),
              empty: () => EmptyStateWidget(
                title: 'لا توجد عروض',
                subTitle: 'لم تقم بتقديم أي عرض على إعلانات العملاء حتى الآن.',
                onRetry: () => context.read<DriverAppliedPostsCubit>().fetchAppliedPosts(),
              ),
              error: (errorModel) => ErrorStateWidget(
                message: errorModel.message ?? 'حدث خطأ أثناء جلب البيانات',
                onRetry: () => context.read<DriverAppliedPostsCubit>().fetchAppliedPosts(),
              ),
              success: (posts) => RefreshIndicator(
                color: theme.colorScheme.primary,
                onRefresh: () async => context.read<DriverAppliedPostsCubit>().fetchAppliedPosts(),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 85.h),
                  itemCount: posts.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) => DriverAppliedPostCard(
                    key: ValueKey(posts[index].id),
                    post: posts[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}