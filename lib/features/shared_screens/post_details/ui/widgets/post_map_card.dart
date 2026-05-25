// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_progect/core/theming/app_colors.dart';
// import 'package:graduation_progect/features/shared_screens/post_details/data/models/post_details_model.dart';
// import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_fullscreen_screen.dart';
// import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_route_view.dart';
// import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/lat_lng_parser.dart';
// import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/map/map_no_route_card.dart';
// import 'package:latlong2/latlong.dart';

// class PostMapCard extends StatelessWidget {
//   final PostDetailsModel post;
//   final bool isDark;

//   const PostMapCard({
//     super.key,
//     required this.post,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final start = LatLngParser.parse(post.startPositionLat, post.startPositionLng);
//     final end = LatLngParser.parse(post.endPositionLat, post.endPositionLng);
    

//     final List<LatLng> points = [];


//     final hasRoute = start != LatLngParser.zero || end != LatLngParser.zero;

//     if (!hasRoute) return MapNoRouteCard(isDark: isDark);

//     return GestureDetector(
//       onTap: () {
//         HapticFeedback.lightImpact();
//         Navigator.of(context).push(PageRouteBuilder(

//           pageBuilder: (_, __, ___) =>
//               MapFullscreenScreen(points: points, start: start, end: end),
//           transitionsBuilder: (_, anim, __, child) => SlideTransition(
//             position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
//                 .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
//             child: child,
//           ),
//           transitionDuration: const Duration(milliseconds: 320),
//         ));
//       },
//       child: _PostMapPreviewCard(points: points, start: start, end: end, isDark: isDark),
//     );
//   }
// }

// class _PostMapPreviewCard extends StatelessWidget {
//   final List<LatLng> points;
//   final LatLng start;
//   final LatLng end;
//   final bool isDark;

//   const _PostMapPreviewCard({
//     required this.points,
//     required this.start,
//     required this.end,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
//     return Container(
//       height: 200.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: border),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.22 : 0.06),
//             blurRadius: 14,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15.r),

//             child: MapRouteView(
//               points: points,
//               start: start,
//               end: end,
//               interactive: false,
//             ),
//           ),
//           // Gradient overlay
//           Positioned.fill(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15.r),
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.transparent,
//                       Colors.black.withOpacity(0.45),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Bottom chips
//           Positioned(
//             bottom: 12.h,
//             left: 12.w,
//             right: 12.w,
//             child: Row(
//               children: [
//                 _MapChip(icon: Icons.fullscreen_rounded, label: 'عرض الخريطة كاملة'),
//               ],
//             ),
//           ),
//           // Badge
//           Positioned(
//             top: 10.h,
//             right: 10.w,
//             child: Container(
//               width: 32.w,
//               height: 32.w,
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(10.r),
//                 boxShadow: [
//                   BoxShadow(color: AppColors.primary.withOpacity(0.40), blurRadius: 8),
//                 ],
//               ),
//               child: Icon(Icons.map_rounded, color: Colors.white, size: 16.sp),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _MapChip extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _MapChip({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.50),
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: Colors.white.withOpacity(0.15)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 12.sp),
//           SizedBox(width: 4.w),
//           Text(label, style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }