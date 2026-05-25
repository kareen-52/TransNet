import 'package:flutter/material.dart';
import 'package:graduation_progect/features/user/available_drivers/logic/available_drivers_cubit.dart';

class ShipmentDialogsHelper {
  static void confirmDelete(BuildContext context, AvailableDriversCubit cubit) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text(
          'هل أنت متأكد أنك تريد حذف طلب الشحن الحالي نهائياً؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              cubit.deleteShipment();
    
              
            },
            child: Text(
              'نعم، احذف',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  static void showExtendDialog(BuildContext context, AvailableDriversCubit cubit,) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('تنبيه'),
        content: const Text(
          'سوف ينتهي مدة البحث بعد 15 دقيقة!\nان لم تقم باختيار السائق سيتم حذف طلبك بعد 15 دقيقة.\nهل ترغب بتمديد وقت البحث لساعة إضافية؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('لا، لا ارغب'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.extendShipmentTime();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('نعم، تمديد'),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showExitWarning(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مغادرة البحث؟'),
        content: const Text(
          'إذا غادرت هذه الشاشة، سيبقى طلبك معلقاً وسوف يتوقف البحث المباشر.\nيمكنك العودة للبحث من الصفحة الرئيسية.\nهل تريد المغادرة؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text('البقاء هنا'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('نعم، غادر'),
          ),
        ],
      ),
    );
  }
}
