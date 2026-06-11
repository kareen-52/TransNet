import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/user/review_driver/logic/review_driver_cubit.dart';
import 'package:graduation_progect/features/user/review_driver/logic/review_driver_state.dart';

class ReviewBottomSheet extends StatefulWidget {
  final int driverId;
  const ReviewBottomSheet({super.key, required this.driverId});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final TextEditingController _reviewController = TextEditingController();
  double _currentRate = 0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<ReviewDriverCubit, ReviewDriverState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (msg) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: AppColors.success),
            );
          },
          error: (err) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(err), backgroundColor: AppColors.error),
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: bottomInset),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'كيف كانت تجربتك مع السائق؟',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    iconSize: 40.sp,
                    icon: Icon(
                      index < _currentRate
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: AppColors.warning,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentRate = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20.h),

              TextField(
                controller: _reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'اكتب رأيك هنا...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              BlocBuilder<ReviewDriverCubit, ReviewDriverState>(
                builder: (context, state) {
                  final isLoading = state == const ReviewDriverState.loading();
                  return SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<ReviewDriverCubit>().submitReview(
                                widget.driverId,
                                _currentRate,
                                _reviewController.text,
                              );
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'إرسال التقييم',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
              verticalSpace(60),
            ],
          ),
        ),
      ),
    );
  }
}
