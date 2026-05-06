import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/features/driver/home/data/repo/home_driver_repo.dart';
import 'package:graduation_progect/features/user/driver_details/ui/widgets/driver_details_bottom_sheet.dart';

class DriverCardHeader extends StatefulWidget {
  final int driverId;
  final String firstName;
  final String lastName;
  final double rating;

  const DriverCardHeader({
    super.key,
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.rating,
  });

  @override
  State<DriverCardHeader> createState() => _DriverCardHeaderState();
}

class _DriverCardHeaderState extends State<DriverCardHeader> {
  Uint8List? _imageBytes;
  bool _isLoadingImage = true;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  void _fetchImage() async {
    final result = await getIt<DriverHomeRepo>().getDriverImage(
      widget.driverId,
    );

    if (mounted) {
      result.when(
        success: (bytes) {
          setState(() {
            _imageBytes = bytes;
            _isLoadingImage = false;
          });
        },
        failure: (_) {
          setState(() {
            _isLoadingImage = false;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          // isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => DriverDetailsBottomSheet(
            driverId: widget.driverId,
            imageBytes: _imageBytes,
          ),
        );
      },
      // borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 65.w,
              height: 75.h,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: theme.colorScheme.surface,
                    child: ClipOval(
                      child: _isLoadingImage
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.colorScheme.primary,
                            )
                          : _imageBytes != null
                          ? Image.memory(
                              _imageBytes!,
                              width: 110.r,
                              height: 110.r,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                              size: 40.sp,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE6D4),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.rating.toString(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeightHelper.bold,
                            ),
                          ),
                          horizontalSpace(4),
                          Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 15.sp,
                          ),
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
