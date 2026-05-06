// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:graduation_progect/core/helpers/spacing.dart';
// import 'package:graduation_progect/features/user/available_drivers/data/models/driver_model.dart';
// import 'package:graduation_progect/features/user/available_drivers/ui/widgets/driver_card_widget.dart';

// class WaitingDriverView extends StatefulWidget {
//   final DriverModel driver;
//   final VoidCallback onCancel;

//   const WaitingDriverView({super.key, required this.driver, required this.onCancel});

//   @override
//   State<WaitingDriverView> createState() => _WaitingDriverViewState();
// }

// class _WaitingDriverViewState extends State<WaitingDriverView> {
//   int _remainingSeconds = 600; // 10 دقائق = 600 ثانية
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingSeconds > 0) {
//         setState(() => _remainingSeconds--);
//       } else {
//         _timer.cancel(); // הـ Cubit سيتكفل بطردنا عندما يصل للصفر
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   String get _formattedTime {
//     int minutes = _remainingSeconds ~/ 60;
//     int seconds = _remainingSeconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//       child: Column(
//         children: [
//           // 1. مؤشر الحالة
//           Text(
//             'في انتظار رد السائق...', 
//             style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)
//           ),
//           verticalSpace(16),

//           // 2. العداد التنازلي الدائري (Progress Bar & Timer)
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 120.w,
//                 height: 120.w,
//                 child: CircularProgressIndicator(
//                   value: _remainingSeconds / 600, // تناقص تدريجي
//                   strokeWidth: 8,
//                   backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
//                   color: theme.colorScheme.primary,
//                 ),
//               ),
//               Text(
//                 _formattedTime, 
//                 style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp)
//               ),
//             ],
//           ),
//           verticalSpace(40),

//           DriverCardWidget(
//             driver: widget.driver,
//           ),
          
//           const Spacer(),

//           // 4. زر سحب الطلب
//           TextButton(
//             onPressed: widget.onCancel,
//             style: TextButton.styleFrom(
//               backgroundColor: theme.colorScheme.error.withOpacity(0.1),
//               padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.cancel_outlined, color: theme.colorScheme.error, size: 20.sp),
//                 horizontalSpace(8),
//                 Text('إلغاء الطلب وسحبه', style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold, fontSize: 16.sp)),
//               ],
//             ),
//           ),
//           verticalSpace(24),
//         ],
//       ),
//     );
//   }
// }