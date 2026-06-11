import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';

class AvailabilityToggle extends StatefulWidget {
  final bool isAvailable;

  const AvailabilityToggle({super.key, required this.isAvailable});

  @override
  State<AvailabilityToggle> createState() => _AvailabilityToggleState();
}

class _AvailabilityToggleState extends State<AvailabilityToggle> {
  late bool _localAvailable;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _localAvailable = widget.isAvailable;
  }

  @override
  void didUpdateWidget(covariant AvailabilityToggle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAvailable != oldWidget.isAvailable && !_isLoading) {
      _localAvailable = widget.isAvailable;
    }
  }

  Future<void> _onToggle() async {
    if (_isLoading) return;
    final cubit = context.read<DriverHomeCubit>();

    setState(() => _isLoading = true);

    final success = await cubit.toggleAvailabilityWithOptimisticUpdate();

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (success) {
          _localAvailable = cubit.isAvailable;
          print(
            "✅ تم تغيير الحالة بنجاح: ${_localAvailable ? 'متاح' : 'غير متاح'}",
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.surface;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _localAvailable
            ? theme.colorScheme.primary.withOpacity(0.25)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _isLoading
                ? SizedBox(
                    width: 32.w,
                    height: 32.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: activeColor,
                    ),
                  )
                : Switch(
                    value: _localAvailable,
                    activeColor: activeColor,
                    inactiveThumbColor: inactiveColor,
                    onChanged: (_) => _onToggle(),
                  ),

            Text(
              _localAvailable ? 'انت الآن متاح للعمل' : 'انت الآن غير متاح',
              style: textTheme.titleMedium?.copyWith(
                color: _localAvailable
                    ? activeColor
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}