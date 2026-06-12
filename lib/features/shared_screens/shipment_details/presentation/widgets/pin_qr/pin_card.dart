import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/common/card_decoration.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/copy_button.dart';


class PinCard extends StatefulWidget {
  final String pin;
  final bool isDark;

  const PinCard({super.key, required this.pin, required this.isDark});

  @override
  State<PinCard> createState() => _PinCardState();
}

class _PinCardState extends State<PinCard> {
  bool _hidden = true;
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.pin));
    HapticFeedback.lightImpact();
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final surface =
        widget.isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border =
        widget.isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final secondary = widget.isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: buildCardDecoration(
          surface: surface, border: border, isDark: widget.isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PinHeader(
            secondary: secondary,
            hidden: _hidden,
            onToggle: () => setState(() => _hidden = !_hidden),
          ),
          SizedBox(height: 12.h),
          _PinDisplay(pin: widget.pin, hidden: _hidden),
          SizedBox(height: 12.h),
          CopyButton(copied: _copied, label: 'نسخ الـ PIN', onTap: _copy),
        ],
      ),
    );
  }
}



class _PinHeader extends StatelessWidget {
  final Color secondary;
  final bool hidden;
  final VoidCallback onToggle;

  const _PinHeader({
    required this.secondary,
    required this.hidden,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(Icons.pin_outlined, size: 16.sp, color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(width: 8.w),
        Text(
          'رمز PIN',
          style: TextStyle(
              fontSize: 12.sp, color: secondary, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onToggle,
          child: Icon(
            hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 16.sp,
            color: secondary,
          ),
        ),
      ],
    );
  }
}

class _PinDisplay extends StatelessWidget {
  final String pin;
  final bool hidden;

  const _PinDisplay({required this.pin, required this.hidden});

  @override
  Widget build(BuildContext context) {
    return Text(
      hidden ? '•' * math.min(pin.length, 6) : pin,
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w900,
        letterSpacing: 4,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
