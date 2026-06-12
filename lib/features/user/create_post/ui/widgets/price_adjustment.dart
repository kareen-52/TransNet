import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/user/client_posts/data/models/post_model.dart';
import 'package:graduation_progect/features/user/client_posts/logic/client_posts_cubit.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_state.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';

class PriceAdjustmentScreen extends StatefulWidget {
  final PostModel post;
  const PriceAdjustmentScreen({super.key, required this.post});

  @override
  State<PriceAdjustmentScreen> createState() => _PriceAdjustmentScreenState();
}

class _PriceAdjustmentScreenState extends State<PriceAdjustmentScreen> {
  late double currentMin;
  late double currentMax;

  late final double baseMin;
  late final double baseMax;

  final double step = 500.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    baseMin = widget.post.minPrice?.toDouble() ?? 0;
    baseMax = widget.post.maxPrice?.toDouble() ?? 0;
    currentMin = baseMin;
    currentMax = baseMax;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatNumber(double num) {
    return num.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  void _increaseMin() {
    if (currentMin + step < currentMax) setState(() => currentMin += step);
  }

  void _decreaseMin() {
    if (currentMin - step >= baseMin) setState(() => currentMin -= step);
  }

  void _increaseMax() {
    if (currentMax + step <= baseMax) setState(() => currentMax += step);
  }

  void _decreaseMax() {
    if (currentMax - step > currentMin) setState(() => currentMax -= step);
  }

  void _startContinuousAction(VoidCallback action) {
    action();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      action();
    });
  }

  void _stopContinuousAction() {
    _timer?.cancel();
  }

  bool get isPriceChanged => currentMin != baseMin || currentMax != baseMax;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تأكيد التسعيرة والنشر'),
        centerTitle: true,
      ),
      body: BlocConsumer<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          state.whenOrNull(
            stepTwoSuccess: (msg) {
              SnackBarHelper.showSuccess(context, msg);
              Navigator.pop(context, true);
            },
            submitError: (err) =>
                SnackBarHelper.showError(context, err.getAllErrorMessages()),
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: theme.colorScheme.primary,
                        size: 24.sp,
                      ),
                      horizontalSpace(12),
                      Expanded(
                        child: Text(
                          'يمكنك تغيير النطاق ولكن لا يمكنك تخطي الحدود المقترحة.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: theme.colorScheme.onSurface.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(40),

                _buildCounterCard(
                  theme: theme,
                  title: 'الحد الأدنى للسعر',
                  currentValue: currentMin,
                  baseValue: baseMin,
                  onIncrease: currentMin + step < currentMax
                      ? _increaseMin
                      : null,
                  onDecrease: currentMin - step >= baseMin
                      ? _decreaseMin
                      : null,
                  helperText: 'لا يمكن أن يقل عن ${_formatNumber(baseMin)} ل.س',
                ),
                verticalSpace(24),

                _buildCounterCard(
                  theme: theme,
                  title: 'الحد الأعلى للسعر',
                  currentValue: currentMax,
                  baseValue: baseMax,
                  onIncrease: currentMax + step <= baseMax
                      ? _increaseMax
                      : null,
                  onDecrease: currentMax - step > currentMin
                      ? _decreaseMax
                      : null,
                  helperText:
                      'لا يمكن أن يزيد عن ${_formatNumber(baseMax)} ل.س',
                ),
                const Spacer(),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextButton(
                        text: 'نشر بالسعر المقترح',
                        textStyle: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(
                              fontSize: 14.sp,
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                        isLoading: false,
                        borderSide: BorderSide(
                          color: theme.colorScheme.secondary,
                        ),
                        backgroundColor: theme.colorScheme.secondary
                            .withOpacity(0.1),
                        onPressed: isLoading
                            ? null
                            : () {
                                SnackBarHelper.showSuccess(
                                  context,
                                  "تم نشر الإعلان بالسعر المقترح",
                                );
                                Navigator.pop(context, true);

                                try {
                                  getIt<ClientPostsCubit>().fetchMyPosts();
                                } catch (_) {}
                              },
                      ),
                    ),
                    horizontalSpace(6),
                    Expanded(
                      flex: 1,
                      child: AppTextButton(
                        text: 'نشر بالسعر المعدّل',
                        textStyle: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(
                              fontSize: 14.sp,
                              color: theme.colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                        isLoading: isLoading,
                        backgroundColor: theme.colorScheme.secondary,
                        onPressed: (isLoading || !isPriceChanged)
                            ? null
                            : () {
                                context
                                    .read<CreatePostCubit>()
                                    .confirmAndPublishPrices(
                                      widget.post.id,
                                      currentMin,
                                      currentMax,
                                    );
                                try {
                                  getIt<ClientPostsCubit>().fetchMyPosts();
                                } catch (_) {}
                              },
                      ),
                    ),
                  ],
                ),
                verticalSpace(24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCounterCard({
    required ThemeData theme,
    required String title,
    required double currentValue,
    required double baseValue,
    required VoidCallback? onIncrease,
    required VoidCallback? onDecrease,
    required String helperText,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRoundButton(
                icon: Icons.remove_rounded,
                onAction: onDecrease,
                color: Theme.of(context).colorScheme.error,
              ),
              Text(
                '${_formatNumber(currentValue)} ل.س',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                  fontSize: 22.sp,
                ),
              ),
              _buildRoundButton(
                icon: Icons.add_rounded,
                onAction: onIncrease,
                color: AppColors.success,
              ),
            ],
          ),
          verticalSpace(16),
          Text(
            helperText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton({
    required IconData icon,
    required VoidCallback? onAction,
    required Color color,
  }) {
    final bool isDisabled = onAction == null;
    return GestureDetector(
      onTap: onAction,
      onLongPress: isDisabled ? null : () => _startContinuousAction(onAction),
      onLongPressEnd: (_) => _stopContinuousAction(),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isDisabled
              ? Theme.of(context).colorScheme.outline
              : color.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDisabled ? Colors.transparent : color.withOpacity(0.3),
          ),
        ),
        child: Icon(
          icon,
          color: isDisabled ? Colors.grey.shade400 : color,
          size: 24.sp,
        ),
      ),
    );
  }
}
