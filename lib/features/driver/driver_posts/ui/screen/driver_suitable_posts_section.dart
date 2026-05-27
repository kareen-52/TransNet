import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/driver/driver_posts/logic/driver_posts_cubit.dart';
import 'package:graduation_progect/features/driver/driver_posts/logic/driver_posts_state.dart';
import 'package:graduation_progect/features/driver/driver_posts/ui/widgets/driver_post_card.dart';
import 'package:graduation_progect/features/user/client_posts/ui/screen/posts_shimmer.dart';

class DriverSuitablePostsSection extends StatelessWidget {
  const DriverSuitablePostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الإعلانات المناسبة لك',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        verticalSpace(16),

        BlocBuilder<DriverPostsCubit, DriverPostsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const PostsShimmer(),
              loading: () => const PostsShimmer(),
              empty: () => EmptyStateWidget(
                title: 'لا توجد إعلانات حالياً',
                subTitle:
                    'لم نجد إعلانات شحنات تتوافق مع مواصفات مركبتك والمحافظات التي تعمل بها.',
                onRetry: () =>
                    context.read<DriverPostsCubit>().fetchSuitablePosts(),
              ),
              error: (errorModel) => ErrorStateWidget(
                message: errorModel.message ?? 'حدث خطأ أثناء جلب الإعلانات',
                onRetry: () =>
                    context.read<DriverPostsCubit>().fetchSuitablePosts(),
              ),
              success: (posts) {
                if (isTablet) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      // childAspectRatio: 1.2,
                      mainAxisExtent: 302.h,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return DriverPostCard(
                        key: ValueKey(posts[index].id),
                        post: posts[index],
                      );
                    },
                  );
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      return DriverPostCard(
                        key: ValueKey(posts[index].id),
                        post: posts[index],
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
