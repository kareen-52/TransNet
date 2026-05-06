import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/driver/driverReviews/logic/driver_reviews_cubit.dart';
import 'package:graduation_progect/features/driver/driverReviews/logic/driver_reviews_state.dart';
import 'package:graduation_progect/features/driver/driverReviews/ui/widgets/rating_header.dart';
import 'package:graduation_progect/features/driver/driverReviews/ui/widgets/review_card.dart';

class DriverReviewsScreen extends StatelessWidget {
  final int driverId;

  const DriverReviewsScreen({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DriverReviewsCubit>()..getDriverReviews(driverId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تقييمات السائق',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: BlocBuilder<DriverReviewsCubit, DriverReviewsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (response) {
                final data = response.data;
                final reviews = data?.reviews ?? [];
                final average = data?.averageRate ?? 0.0;
                final count = data?.reviewsCount ?? 0;

                return Column(
                  children: [
                    RatingHeader(averageRate: average, reviewsCount: count),
                    Expanded(
                      child: reviews.isEmpty
                          ? Center(
                              child: Text(
                                'لا توجد تقييمات بعد',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              itemCount: reviews.length,
                              itemBuilder: (context, index) =>
                                  ReviewCard(review: reviews[index]),
                            ),
                    ),
                  ],
                );
              },
              error: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.sp,
                      color: AppColors.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      error.message ?? 'حدث خطأ في تحميل التقييمات',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context
                          .read<DriverReviewsCubit>()
                          .getDriverReviews(driverId),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
