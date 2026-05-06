import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:graduation_progect/features/driver/driverReviews/ui/screens/driver_reviews_screen.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/profile/ui/screen/driver_car_details_screen.dart';
import 'package:graduation_progect/features/driver/profile/ui/screen/driver_transport_lines_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/profile_nav_item.dart';
import 'package:graduation_progect/features/shared_screens/profile_widgets/profile_section_container.dart';

class WorkSection extends StatelessWidget {
  final CarData? car;
  final List<GovernorateData>? governorates;

  const WorkSection({super.key, required this.car, required this.governorates});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تفاصيل العمل',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12.h),

        ProfileSectionContainer(
          children: [
            ProfileNavItem(
              title: 'تفاصيل وسيلة النقل',
              icon: Icons.directions_car_outlined,
              onTap: () {
                if (car != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarDetailsScreen(carData: car!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا توجد بيانات للسيارة')),
                  );
                }
              },
            ),

            const Divider(height: 1, indent: 70, endIndent: 60),

            ProfileNavItem(
              title: 'خطوط النقل',
              icon: Icons.route_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportLinesScreen(
                      governorates: governorates,
                      profileCubit: profileCubit,
                    ),
                  ),
                );
              },
            ),

            const Divider(height: 1, indent: 70, endIndent: 60),

            ProfileNavItem(
              title: 'الأرباح',
              icon: Icons.account_balance_wallet_outlined,
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('قريباً...')));
              },
            ),
            const Divider(height: 1, indent: 70, endIndent: 60),
            ProfileNavItem(
              title: 'المراجعات',
              icon: Icons.reviews_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(

                    builder: (context) => DriverReviewsScreen(
                      driverId: SharedPrefHelper.getInt(
                        SharedPrefKeys.driverId,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

