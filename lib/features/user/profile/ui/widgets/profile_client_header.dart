import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';

class ClientProfileHeader extends StatelessWidget {
  final UserData? userData;

  const ClientProfileHeader({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.onSurface.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: CircleAvatar(
                radius: 54.r,
                backgroundColor: colorScheme.outline,
                child: Icon(Icons.person, size: 50.sp),
              ),
            ),
          ],
        ),
        verticalSpace(16),
        Text(
          '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        verticalSpace(16),
      ],
    );
  }
}
