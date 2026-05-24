import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';
import 'package:graduation_progect/features/user/driver_details/ui/widgets/driver_details_bottom_sheet.dart';

/// Driver card header — uses cubit's session image cache.
///
/// No direct API call from this widget.
/// Image is fetched once per session via AvailableDriversCubit and held
/// in Map<int,Uint8List> — safe across scroll reuse.
class DriverCardHeader extends StatefulWidget {
  final int    driverId;
  final String firstName;
  final String lastName;
  final double? rating;

  const DriverCardHeader({
    super.key,
    required this.driverId,
    required this.firstName,
    required this.lastName,
    this.rating,
  });

  @override
  State<DriverCardHeader> createState() => _DriverCardHeaderState();
}

class _DriverCardHeaderState extends State<DriverCardHeader> {
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(DriverCardHeader old) {
    super.didUpdateWidget(old);
    if (old.driverId != widget.driverId) _loadImage();
  }

  void _loadImage() {
    final cubit = context.read<AvailableDriversCubit>();

    // Check if already in session cache — instant, no rebuild
    final cached = cubit.getDriverImageSync(widget.driverId);
    if (cached != null) {
      _imageBytes = cached;
      return;
    }

    // Not in cache → ask cubit to fetch (once) and notify us via callback
    cubit.prefetchDriverImage(
      widget.driverId,
      onLoaded: (bytes) {
        if (mounted) setState(() => _imageBytes = bytes);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => DriverDetailsBottomSheet(
          driverId:   widget.driverId,
          imageBytes: _imageBytes,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width:  65.w,
              height: 75.h,
              child: Stack(
                alignment:    Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius:          30.r,
                    backgroundColor: theme.colorScheme.surface,
                    child: ClipOval(
                      child: _imageBytes != null
                          ? Image.memory(
                              _imageBytes!,
                              width:  60.r,
                              height: 60.r,
                              fit:    BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                              size:  40.sp,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical:   2.h,
                      ),
                      decoration: BoxDecoration(
                        color:        const Color(0xFFEDE6D4),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color:      theme.colorScheme.shadow.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            (widget.rating ?? 0.0).toStringAsFixed(1),
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeightHelper.bold,
                            ),
                          ),
                          horizontalSpace(4),
                          Icon(Icons.star, color: AppColors.warning, size: 15.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            horizontalSpace(8),
            Expanded(
              child: Text(
                '${widget.firstName} ${widget.lastName}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeightHelper.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
