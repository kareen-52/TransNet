import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/domain/entities/shipment_details_entity.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/utils/date_formatter.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/presentation/widgets/share/share_bottom_sheet.dart';

abstract class ShareService {
  static Future<void> shareShipmentDetails(
    BuildContext context,
    ShipmentDetailsEntity data,
  ) {
    final text = _buildShareText(data);
    return ShareBottomSheet.show(context, data: data, shareText: text);
  }

  static Future<void> copyToClipboard(ShipmentDetailsEntity data) async {
    final text = _buildShareText(data);
    await Clipboard.setData(ClipboardData(text: text));
  }

  static String _buildShareText(ShipmentDetailsEntity data) {
    final s = data.shipment;
    final buf = StringBuffer();

    buf.writeln('📦 تفاصيل الشحنة');
    buf.writeln('━━━━━━━━━━━━━━━━━━━━');
    buf.writeln('🔢 رقم الشحنة: #${s.shipmentNumber}');
    buf.writeln('📌 الحالة: ${s.status}');
    buf.writeln('━━━━━━━━━━━━━━━━━━━━');
    buf.writeln('📍 من: ${s.startGovernorate}');
    buf.writeln('🏁 إلى: ${s.endGovernorate}');

    if (s.price != null) {
      buf.writeln('━━━━━━━━━━━━━━━━━━━━');
      buf.writeln('💰 السعر: ${s.price} ل.س');
    }
    if (s.hasInsurance) {
      buf.writeln('🛡 التأمين: مؤمَّن ✅');
    }

    // if (s.paid != null) {
    //   buf.writeln('━━━━━━━━━━━━━━━━━━━━');
    // //  buf.writeln('💳 الدفع: ${s.isPaid ? "مدفوع ✅" : "غير مدفوع ❌"}');
    // }

    if (s.deliveryDeadline != null) {
      buf.writeln(
          '📅 موعد التسليم: ${DateFormatter.format(s.deliveryDeadline)}');
    }

    if (s.object != null) {
      buf.writeln('━━━━━━━━━━━━━━━━━━━━');
      buf.writeln('📦 نوع المحمول: ${s.object}');
    }
    if (s.weight != null) buf.writeln('⚖️ الوزن: ${s.weight} كغم');

    if (data.hasDriver) {
      final d = data.driver!;
      buf.writeln('━━━━━━━━━━━━━━━━━━━━');
      buf.writeln('🚗 السائق: ${d.fullName}');
      buf.writeln('📞 ${d.phoneNumber}');
    }

    if (s.hasPin) {
      buf.writeln('━━━━━━━━━━━━━━━━━━━━');
      buf.writeln('🔐 رمز PIN: ${s.pin}');
    }

    buf.writeln('━━━━━━━━━━━━━━━━━━━━');
    buf.write('تم الإرسال عبر تطبيق الشحن');
    return buf.toString();
  }

  static String buildPdfText(ShipmentDetailsEntity data) =>
      _buildShareText(data);
}
