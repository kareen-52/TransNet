import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/main.dart';

class OfflineBanner {
  static OverlayEntry? _overlayEntry;

  static void show() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          bottom: false,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              color: Colors.red.shade700,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 18.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      ' لا يوجد اتصال بالإنترنت - يتم عرض آخر نسخة محفوظة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final overlay = navigatorKey.currentState?.overlay;
    if (overlay != null) {
      overlay.insert(_overlayEntry!);
    }
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}