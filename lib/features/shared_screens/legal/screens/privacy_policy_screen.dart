import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/shared_screens/legal/widgets/legal_section.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String _supportEmail = 'application.shipments@gmail.com';
  static const String _lastUpdated = '14 أغسطس 2026'; // تعديل التاريخ عند كل نشر فعلي

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: _supportEmail));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: Text('تم نسخ البريد الإلكتروني', style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LegalHeaderCard(
              appName: 'TransNet',
              lastUpdated: _lastUpdated,
              icon: Icons.privacy_tip_rounded,
            ),

            Text(
              'نحن في TransNet نأخذ خصوصية بياناتك على محمل الجد. توضّح هذه '
              'السياسة ما هي المعلومات التي نجمعها عنك عند استخدامك للتطبيق '
              '(كعميل أو كسائق)، وكيف نستخدمها ونحميها، وما هي حقوقك '
              'المتعلقة بها.',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
            ),
            verticalSpace(20),

            LegalSection(
              number: 1,
              icon: Icons.badge_outlined,
              title: 'المعلومات التي نجمعها',
              bullets: const [
                'بيانات الحساب: الاسم الأول واسم العائلة، البريد الإلكتروني، رقم الموبايل، وكلمة المرور (مخزّنة بشكل مشفّر).',
                'بيانات إضافية للسائقين: نوع المركبة، موديلها، رقم اللوحة، وحالة تفعيل الحساب كسائق.',
                'الموقع الجغرافي (GPS): للسائق أثناء وضع "متاح" لتحديد موقعه للعملاء وتتبع الشحنة لحظياً. للعميل عند تحديد نقاط الانطلاق والوصول على الخريطة عند إنشاء شحنة أو إعلان.',
                'بيانات الشحنات والإعلانات: نوع البضاعة، وزنها وأبعادها، نقاط الاستلام والتسليم، السعر، وحالة الشحنة.',
                'الصورة الشخصية (اختياري) إن قام المستخدم برفعها.',
                'رمز إشعارات الجهاز (FCM Token) لإرسال إشعارات الطلبات والتحديثات.',
                'صلاحية الكاميرا: تُستخدم فقط لمسح رمز QR عند تأكيد استلام الشحنة، ولا يتم تخزين أو رفع أي صورة أو فيديو من الكاميرا.',
              ],
            ),

            LegalSection(
              number: 2,
              icon: Icons.settings_suggest_outlined,
              title: 'كيف نستخدم معلوماتك',
              bullets: const [
                'لتشغيل الخدمة الأساسية: مطابقة العملاء بالسائقين المناسبين وإدارة الشحنات من الإنشاء حتى التسليم.',
                'لإرسال إشعارات فورية بخصوص حالة الشحنة أو الطلبات أو العروض.',
                'لتحديد موقع السائق وعرضه للعميل أثناء نقل الشحنة النشطة فقط.',
                'للتواصل معك عند الحاجة للدعم الفني أو حل مشكلة بشحنة.',
                'لتحسين أداء التطبيق واكتشاف الأخطاء وإصلاحها.',
              ],
            ),

            LegalSection(
              number: 3,
              icon: Icons.share_outlined,
              title: 'مشاركة المعلومات',
              body:
                  'لا نبيع بياناتك الشخصية لأي طرف ثالث لأغراض تسويقية. '
                  'يتم مشاركة معلومات محدودة فقط بين طرفي الشحنة (اسم '
                  'وموقع ورقم هاتف السائق/العميل) بالقدر اللازم لإتمام '
                  'عملية التوصيل. كما نستخدم خدمات تقنية من أطراف ثالثة '
                  'موثوقة (مثل Firebase من Google) لإرسال الإشعارات '
                  'وتخزين الصور، وهذه الخدمات تخضع لسياسات الخصوصية '
                  'الخاصة بها.',
            ),

            LegalSection(
              number: 4,
              icon: Icons.shield_outlined,
              title: 'أمان بياناتك',
              body:
                  'نستخدم كلمات مرور مشفّرة، واتصال آمن (HTTPS) بين '
                  'التطبيق والخادم، وتخزين آمن لبيانات تسجيل الدخول '
                  'على جهازك. مع ذلك، لا توجد وسيلة نقل أو تخزين '
                  'إلكتروني آمنة بنسبة 100%، ونعمل باستمرار على تحسين '
                  'إجراءات الحماية لدينا.',
            ),

            LegalSection(
              number: 5,
              icon: Icons.timelapse_outlined,
              title: 'الاحتفاظ بالبيانات',
              body:
                  '🔸 نحتفظ ببيانات حسابك طالما بقي الحساب فعّالاً. '
                  'عند حذف الحساب يتم حذف بياناتك الشخصية أو إخفاؤها، '
                  'باستثناء ما يلزم الاحتفاظ به لأغراض قانونية أو '
                  'محاسبية (سجلات الشحنات المكتملة) لمدة [حددي المدة، '
                  'مثلاً سنة واحدة].',
            ),

            LegalSection(
              number: 6,
              icon: Icons.fact_check_outlined,
              title: 'حقوقك',
              bullets: const [
                'الاطلاع على بياناتك الشخصية المخزنة لدينا.',
                'تعديل بياناتك (الاسم، رقم الهاتف...) من صفحة البروفايل.',
                'طلب حذف حسابك وبياناتك بالتواصل معنا عبر البريد أدناه.',
                'إيقاف مشاركة موقعك بأي وقت بتفعيل حالة "غير متاح" (للسائق).',
              ],
            ),

            LegalSection(
              number: 7,
              icon: Icons.child_care_outlined,
              title: 'خصوصية القاصرين',
              body:
                  '🔸 هذا التطبيق غير موجّه للأشخاص دون سن [حددي السن، '
                  'عادة 18 عاماً]، ولا نجمع عن قصد بيانات من قاصرين. '
                  'إذا تبيّن لنا أننا جمعنا بيانات كهذه سنقوم بحذفها فوراً.',
            ),

            LegalSection(
              number: 8,
              icon: Icons.update_rounded,
              title: 'التعديلات على هذه السياسة',
              body:
                  'قد نقوم بتحديث سياسة الخصوصية من وقت لآخر. سيتم '
                  'إعلامك بأي تغييرات جوهرية عبر إشعار داخل التطبيق، '
                  'ويُعتبر استمرارك باستخدام التطبيق بعد التحديث موافقة '
                  'ضمنية على السياسة المُحدّثة.',
            ),

            verticalSpace(4),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'لأي استفسار حول خصوصيتك',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(8),
                  InkWell(
                    onTap: () => _copyEmail(context),
                    borderRadius: BorderRadius.circular(8.r),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 18.sp,
                          color: theme.colorScheme.primary,
                        ),
                        horizontalSpace(8),
                        Text(
                          _supportEmail,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
