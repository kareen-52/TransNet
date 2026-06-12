import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/review_driver/logic/review_driver_cubit.dart';
import 'package:graduation_progect/features/user/review_driver/logic/review_driver_state.dart';

class ReviewDialog extends StatefulWidget {
  final int driverId;
  const ReviewDialog({super.key, required this.driverId});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
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

    return BlocListener<ReviewDriverCubit, ReviewDriverState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (msg) {
            Navigator.pop(context);
            SnackBarHelper.showSuccess(context, msg);
          },
          error: (err) {
            Navigator.pop(context);
            SnackBarHelper.showError(context, err);
          },
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        backgroundColor: theme.colorScheme.surface,
        insetPadding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close_rounded, color: Colors.grey, size: 24.sp),
                  ),
                ),
                

                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(Icons.star_rounded, color: AppColors.warning, size: 36.sp),
                ),
                verticalSpace(16),
                Text(
                  'كيف كانت تجربتك مع السائق؟',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      iconSize: 40.sp,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        index < _currentRate ? Icons.star_rounded : Icons.star_outline_rounded,
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
                verticalSpace(24),


                TextField(
                  controller: _reviewController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'اكتب رأيك هنا...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.warning),
                    ),
                  ),
                ),
                verticalSpace(32),


                BlocBuilder<ReviewDriverCubit, ReviewDriverState>(
                  builder: (context, state) {
                    final isLoading = state == const ReviewDriverState.loading();
                    return AppTextButton(
                      text: 'إرسال التقييم',
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<ReviewDriverCubit>().submitReview(
                              widget.driverId,
                              _currentRate,
                              _reviewController.text,
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}