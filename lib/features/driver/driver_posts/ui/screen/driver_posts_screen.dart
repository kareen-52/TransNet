// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_progect/core/di/dependency_injection.dart';
// import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
// import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
// import 'package:graduation_progect/features/user/client_posts/ui/screen/posts_shimmer.dart';
// import '../../logic/driver_posts_cubit.dart';
// import '../../logic/driver_posts_state.dart';
// import '../widgets/driver_post_card.dart';

// class DriverPostsScreen extends StatelessWidget {
//   const DriverPostsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return BlocProvider(
//       create: (context) => getIt<DriverPostsCubit>()..fetchSuitablePosts(),
//       child: Scaffold(
//         // backgroundColor: theme.scaffoldBackgroundColor,
//         body: BlocBuilder<DriverPostsCubit, DriverPostsState>(
//           builder: (context, state) {
//             return state.when(
//               initial: () => const PostsShimmer(),
//               loading: () => const PostsShimmer(),
//               empty: () => EmptyStateWidget(
//                 title: 'لا توجد إعلانات حالياً',
//                 subTitle: 'لم نجد إعلانات شحنات تتوافق مع مواصفات مركبتك والمحافظات التي تعمل بها.',
//                 onRetry: () => context.read<DriverPostsCubit>().fetchSuitablePosts(),
//               ),
//               error: (errorModel) => ErrorStateWidget(
//                 message: errorModel.message ?? 'حدث خطأ أثناء جلب الإعلانات',
//                 onRetry: () => context.read<DriverPostsCubit>().fetchSuitablePosts(),
//               ),
//               success: (posts) => RefreshIndicator(
//                 color: theme.colorScheme.primary,
//                 onRefresh: () async => context.read<DriverPostsCubit>().fetchSuitablePosts(),
//                 child: ListView.separated(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 85.h),
//                   itemCount: posts.length,
//                   separatorBuilder: (context, index) => SizedBox(height: 16.h),
//                   itemBuilder: (context, index) => DriverPostCard(
//                     key: ValueKey(posts[index].id),
//                     post: posts[index],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }