import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_progect/features/driver/home/logic/home_driver_cubit.dart';
import 'package:graduation_progect/features/driver/setLocation/logic/driver_location_cubit.dart';

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
    final homeCubit = context.read<DriverHomeCubit>();

    final aboutToTurnOn = !_localAvailable;

    if (aboutToTurnOn) {
      setState(() => _isLoading = true);

      final locationCubit = context.read<DriverLocationCubit>();
      final result = await locationCubit.ensureLocationPermissionGranted();

      if (result != LocationPermissionCheckResult.granted) {
        if (mounted) {
          setState(() => _isLoading = false);
          await _handlePermissionFailure(result);
        }
        return;
      }
    }

    setState(() => _isLoading = true);

    final success = await homeCubit.toggleAvailabilityWithOptimisticUpdate();

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (success) {
          _localAvailable = homeCubit.isAvailable;
        }
      });
    }
  }

  Future<void> _handlePermissionFailure(
    LocationPermissionCheckResult result,
  ) async {
    switch (result) {
      case LocationPermissionCheckResult.serviceDisabled:
        await showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('خدمة الموقع مطفية'),
            content: const Text(
              'لازم تفعّل خدمة الموقع (GPS) بجهازك حتى تقدر تصير متاح '
              'لاستقبال الطلبات.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('إلغاء'),
              ),
              FilledButton(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  await Geolocator.openLocationSettings();
                },
                child: const Text('فتح إعدادات الموقع'),
              ),
            ],
          ),
        );
        break;

      case LocationPermissionCheckResult.deniedForever:
        await showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('صلاحية الموقع مرفوضة'),
            content: const Text(
              'رفضت صلاحية الموقع بشكل نهائي. لازم تفعّلها يدوياً من '
              'إعدادات التطبيق حتى تقدر تصير متاح لاستقبال الطلبات.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('إلغاء'),
              ),
              FilledButton(
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  await Geolocator.openAppSettings();
                },
                child: const Text('فتح إعدادات التطبيق'),
              ),
            ],
          ),
        );
        break;

      case LocationPermissionCheckResult.denied:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'لازم توافق على صلاحية الموقع حتى تصير متاح لاستقبال الطلبات',
            ),
          ),
        );
        break;

      case LocationPermissionCheckResult.granted:
        break;
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