import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // قفل لمنع المكتبة من قراءة الكود أكثر من مرة
  bool _hasScanned = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('امسح رمز العميل (QR)')),
      body: MobileScanner(
        onDetect: (capture) {
          // إذا تم المسح مسبقاً، تجاهل أي قراءات أخرى
          if (_hasScanned) return; 

          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            _hasScanned = true; // تفعيل القفل
            final String code = barcodes.first.rawValue!;
            Navigator.pop(context, code); // العودة مرة واحدة فقط
          }
        },
      ),
    );
  }
}