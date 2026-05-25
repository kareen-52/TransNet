import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_cubit.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_state.dart';
import 'package:graduation_progect/features/user/client_posts/ui/screen/posts_shimmer.dart';
import '../widgets/client_post_card.dart';

class ClientPostsScreen extends StatelessWidget {
  const ClientPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: getIt<ClientPostsCubit>()..fetchMyPosts(),

      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton.extended(
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                Routes.createClientPostScreen,
              );

              if (result == true || result == null) {
                context.read<ClientPostsCubit>().fetchMyPosts();
              }
            },
            backgroundColor: theme.colorScheme.primary,
            elevation: 4,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(60.r),
            ),
            icon: Icon(Icons.add_box_rounded, size: 22.sp),
            label: Text(
              'إعلان جديد',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        body: BlocBuilder<ClientPostsCubit, ClientPostsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const PostsShimmer(),
              loading: () => const PostsShimmer(),
              empty: () => EmptyStateWidget(
                title: 'لا توجد إعلانات',
                subTitle:
                    'لم تقم بنشر أي إعلان لنقل بضائعك حتى الآن.\nاضغط على "إعلان جديد" للبدء.',
                onRetry: () => context.read<ClientPostsCubit>().fetchMyPosts(),
              ),
              error: (errorModel) => ErrorStateWidget(
                message: errorModel.message ?? 'حدث خطأ أثناء جلب الإعلانات',
                onRetry: () => context.read<ClientPostsCubit>().fetchMyPosts(),
              ),
              success: (posts) => RefreshIndicator(
                color: theme.colorScheme.primary,
                onRefresh: () async =>
                    context.read<ClientPostsCubit>().fetchMyPosts(),
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 85.h),
                  itemCount: posts.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) => ClientPostCard(
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
