import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('المساعدة والدعم'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildSection(context, 'الأسئلة الشائعة', Icons.help_outline, [
              _buildFaqItem(
                context,
                'كيف يمكنني تعديل ملفي الشخصي؟',
                'يمكنك تعديل ملفك الشخصي من خلال الضغط على أيقونة التعديل بجانب رقم الهاتف في بطاقة المعلومات الشخصية، ثم قم بتعديل البيانات المطلوبة.',
              ),
              _buildFaqItem(
                context,
                'كيف يمكنني تغيير رقم هاتفي؟',
                'يمكنك تغيير رقم هاتفك من خلال الضغط على أيقونة التعديل بجانب رقم الهاتف في بطاقة المعلومات الشخصية، ثم قم بإدخال الرقم الجديد.',
              ),
              _buildFaqItem(
                context,
                'متى تصل أرباحي؟',
                'تصل أرباحك في نهاية كل شهر إلى حسابك البنكي المسجل في التطبيق.',
              ),
              _buildFaqItem(
                context,
                'كيف يمكنني إضافة خط نقل جديد؟',
                'يمكنك إضافة خط نقل جديد من خلال قسم "خطوط النقل" ثم الضغط على زر الإضافة.',
              ),
              _buildFaqItem(
                context,
                'ماذا أفعل إذا واجهت مشكلة في التطبيق؟',
                'يمكنك التواصل مع فريق الدعم عبر الواتساب أو الاتصال على الرقم الموضح في قسم "تواصل معنا".',
              ),
            ]),
            verticalSpace(24),
            _buildContactSection(context),
            verticalSpace(48),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Icon(icon, color: colorScheme.primary),
                horizontalSpace(12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 13.sp,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Icon(Icons.contact_support, color: colorScheme.primary),
                horizontalSpace(12),
                Text(
                  'تواصل معنا',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          _buildContactItem(
            context,
            'واتساب',
            '845 483 935 963+',
            Icons.chat,
            Colors.green,
            () => _openWhatsApp('+963935483845', context),
          ),
          _buildDivider(context),
          _buildContactItem(
            context,
            'اتصال',
            '845 483 935 963+',
            Icons.phone_android_outlined,
            Colors.blue,
            () => _launchURL('tel:+963935483845', context),
          ),
          _buildDivider(context),
          _buildContactItem(
            context,
            'البريد الإلكتروني',
            'support@shipments.com',
            Icons.email,
            Colors.red,
            () => _launchURL('mailto:application.shipments@gmail.com', context),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22.sp),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      indent: 70.w,
      endIndent: 60.w,
      color: Theme.of(context).colorScheme.outline,
    );
  }

  Future<void> _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);

    try {
      final canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'لا يمكن فتح الرابط';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _openWhatsApp(String phoneNumber, BuildContext context) async {

    String cleanNumber = phoneNumber
        .replaceAll('+', '')
        .replaceAll(' ', '')
        .replaceAll('-', '');

    String whatsappAppUrl = 'whatsapp://send?phone=$cleanNumber';

    try {
      if (await canLaunchUrl(Uri.parse(whatsappAppUrl))) {
        await launchUrl(
          Uri.parse(whatsappAppUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        String whatsappWebUrl = 'https://wa.me/$cleanNumber';
        if (await canLaunchUrl(Uri.parse(whatsappWebUrl))) {
          await launchUrl(
            Uri.parse(whatsappWebUrl),
            mode: LaunchMode.platformDefault,
          );
        } else {
          throw 'الواتساب غير مثبت';
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى تثبيت تطبيق واتساب أولاً'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
