import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';

/// Compact animated copy chip.
///
/// Tapping it copies [value] to the clipboard, plays a haptic pulse,
/// and briefly switches to a green "تم!" confirmation state before
/// reverting. Scale animation is handled by a dedicated
/// [AnimationController] — no external state needed.
class CopyChip extends StatefulWidget {
  final String value;
  final String label;
  final bool isDark;

  const CopyChip({
    super.key,
    required this.value,
    required this.label,
    required this.isDark,
  });

  @override
  State<CopyChip> createState() => _CopyChipState();
}

class _CopyChipState extends State<CopyChip>
    with SingleTickerProviderStateMixin {
  bool _copied = false;
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _handleCopy() async {
    await _scaleController.forward();
    await _scaleController.reverse();
    await Clipboard.setData(ClipboardData(text: widget.value));
    HapticFeedback.lightImpact();
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _handleCopy,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: _copied
                ? AppColors.success.withValues(alpha: 0.12)
                : (widget.isDark
                    ? Colors.white.withValues(alpha: 0.07)
                    : AppColors.primary.withValues(alpha: 0.07)),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: _copied
                  ? AppColors.success.withValues(alpha: 0.4)
                  : (widget.isDark
                      ? Colors.white.withValues(alpha: 0.10)
                      : AppColors.primary.withValues(alpha: 0.20)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _copied ? Icons.check_rounded : Icons.copy_rounded,
                size: 12.sp,
                color: _copied ? AppColors.success : AppColors.primary,
              ),
              SizedBox(width: 4.w),
              Text(
                _copied ? 'تم!' : widget.label,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: _copied ? AppColors.success : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
