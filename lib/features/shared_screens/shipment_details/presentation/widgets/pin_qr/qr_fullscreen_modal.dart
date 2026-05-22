import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/qr_display_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/qr_modal_header.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/qr_pin_row.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/pin_qr/qr_share_actions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:path_provider/path_provider.dart';

/// Full-screen QR code viewer presented over a blurred dark backdrop.
///
/// Features:
///   - Fade + scale entrance animation.
///   - Capture QR as PNG via [RepaintBoundary] for image sharing.
///   - Share as image (WhatsApp, Telegram, …) via share_plus.
///   - PIN displayed separately with its own copy button.
///   - No "copy as text" duplicating the PIN — QrPinRow handles that.
class QrFullscreenModal extends StatefulWidget {
  final String qrPin;

  const QrFullscreenModal({super.key, required this.qrPin});

  @override
  State<QrFullscreenModal> createState() => _QrFullscreenModalState();
}

class _QrFullscreenModalState extends State<QrFullscreenModal>
    with SingleTickerProviderStateMixin {
  final GlobalKey _qrRepaintKey = GlobalKey();
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  bool _isSavingImage = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _scaleAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────────────

  Future<void> _shareAsImage() async {
    setState(() => _isSavingImage = true);
    HapticFeedback.lightImpact();
    try {
      final bytes = await _captureQrAsPng();
      if (bytes == null || !mounted) return;

      // ▶ Uncomment when share_plus + path_provider are in pubspec.yaml:
      //
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/qr_${widget.qrPin}.png');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'image/png')],
        subject: 'رمز QR للشحنة',
      );
      
      _showSnack(' تم مشاركة ');
    } finally {
      if (mounted) setState(() => _isSavingImage = false);
    }
  }

  Future<Uint8List?> _captureQrAsPng() async {
    try {
      final boundary = _qrRepaintKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 80.h),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black.withValues(alpha: 0.80),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: ScaleTransition(
                scale: _scaleAnim,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrModalHeader(onClose: () => Navigator.pop(context)),
                      SizedBox(height: 24.h),

                      // QR card — captured for image sharing
                      QrDisplayCard(
                        repaintKey: _qrRepaintKey,
                        qrPin: widget.qrPin,
                      ),
                      SizedBox(height: 20.h),

                      // PIN + copy button
        

                      // Share as image
                      QrShareActions(
                        isSavingImage: _isSavingImage,
                        onShareImage: _shareAsImage,
                      ),
                      SizedBox(height: 16.h),

                      Text(
                        'اضغط خارج الإطار للإغلاق',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.40),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
