import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/shared_screens/legal/widgets/legal_section.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String _supportEmail = 'application.shipments@gmail.com';
  static const String _lastUpdated = '15 أغسطس 2026';

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: _supportEmail));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم نسخ البريد الإلكتروني'),
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
              'تولي إدارة TransNet خصوصية بيانات مستخدميها أهمية بالغة. '
              'توضّح هذه السياسة طبيعة المعلومات التي يتم جمعها عند '
              'استخدام التطبيق، سواء من قِبل العميل أو السائق، وكيفية '
              'استخدامها وحمايتها، والحقوق المتاحة للمستخدم بشأنها.',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
            ),
            verticalSpace(20),

            LegalSection(
              number: 1,
              icon: Icons.badge_outlined,
              title: 'المعلومات التي يتم جمعها',
              bullets: const [
                'بيانات الحساب: الاسم الأول واسم العائلة، البريد الإلكتروني، رقم الهاتف، وكلمة المرور، وتُخزَّن كلمة المرور بشكل مشفّر.',
                'بيانات إضافية خاصة بالسائق: نوع المركبة وموديلها ورقم لوحتها، وحالة تفعيل الحساب كسائق.',
                'الصورة الشخصية: تُطلب من السائق فقط لأغراض التوثيق وبناء الثقة مع العميل، ولا يُطلب أو يُخزَّن أي صورة شخصية للعميل.',
                'الموقع الجغرافي (GPS): يُستخدم لتحديد موقع السائق أثناء تفعيل حالة "متاح" ولإظهار موقعه للعميل أثناء تنفيذ الشحنة، ويُستخدم لدى العميل عند تحديد نقطتي الانطلاق والوصول على الخريطة عند إنشاء شحنة أو إعلان.',
                'بيانات الشحنات والإعلانات: نوع البضاعة ووزنها وأبعادها، نقاط الاستلام والتسليم، السعر، وحالة الشحنة.',
                'صلاحية الكاميرا: تُستخدم حصراً لمسح رمز الاستجابة السريعة (QR) عند تأكيد استلام الشحنة، ولا يتم تخزين أو رفع أي صورة أو فيديو من الكاميرا.',
              ],
            ),

            LegalSection(
              number: 2,
              icon: Icons.settings_suggest_outlined,
              title: 'كيفية استخدام المعلومات',
              bullets: const [
                'تشغيل الخدمة الأساسية للتطبيق، بما في ذلك مطابقة العملاء بالسائقين المناسبين وإدارة الشحنات من مرحلة الإنشاء حتى التسليم.',
                'إرسال إشعارات فورية بخصوص حالة الشحنة أو الطلبات أو العروض.',
                'تحديد موقع السائق وعرضه للعميل أثناء تنفيذ الشحنة النشطة فقط.',
                'التواصل مع المستخدم عند الحاجة لتقديم الدعم الفني أو حل مشكلة متعلقة بشحنة ما.',
                'تحسين أداء التطبيق واكتشاف الأعطال ومعالجتها.',
              ],
            ),

            LegalSection(
              number: 3,
              icon: Icons.share_outlined,
              title: 'مشاركة المعلومات',
              body:
                  'لا تقوم TransNet ببيع بيانات المستخدمين الشخصية لأي طرف '
                  'ثالث لأغراض تسويقية. تقتصر مشاركة المعلومات على البيانات '
                  'المحدودة اللازمة بين طرفي الشحنة (كالاسم والموقع ورقم '
                  'الهاتف الخاصين بالسائق أو العميل) بالقدر الضروري لإتمام '
                  'عملية التوصيل. كما يستعين التطبيق بخدمات تقنية من أطراف '
                  'ثالثة موثوقة، مثل خدمات Firebase التابعة لشركة Google، '
                  'لإرسال الإشعارات وتخزين البيانات، وتخضع هذه الخدمات '
                  'لسياسات الخصوصية الخاصة بها.',
            ),

            LegalSection(
              number: 4,
              icon: Icons.shield_outlined,
              title: 'أمان البيانات',
              body:
                  'يعتمد التطبيق تشفير كلمات المرور، واتصالاً آمناً '
                  '(HTTPS) بين التطبيق والخادم، وتخزيناً آمناً لبيانات '
                  'تسجيل الدخول على جهاز المستخدم. ومع ذلك، لا توجد وسيلة '
                  'نقل أو تخزين إلكتروني آمنة بنسبة مطلقة، وتعمل إدارة '
                  'التطبيق باستمرار على تطوير إجراءات الحماية المعتمدة.',
            ),

            LegalSection(
              number: 5,
              icon: Icons.fact_check_outlined,
              title: 'حقوق المستخدم',
              bullets: const [
                'الاطلاع على البيانات الشخصية المخزَّنة لدى التطبيق.',
                'تعديل البيانات الشخصية (كالاسم أو رقم الهاتف) من صفحة الملف الشخصي.',
                'إيقاف مشاركة الموقع الجغرافي في أي وقت، عبر تفعيل حالة "غير متاح" (بالنسبة للسائق).',
                'التواصل مع فريق الدعم لأي استفسار أو طلب تصحيح للبيانات عبر البريد الإلكتروني أدناه.',
              ],
            ),

            LegalSection(
              number: 6,
              icon: Icons.update_rounded,
              title: 'التعديلات على هذه السياسة',
              body:
                  'قد تقوم إدارة التطبيق بتحديث سياسة الخصوصية من وقت لآخر. '
                  'وسيتم إعلام المستخدم بأي تغييرات جوهرية عبر إشعار داخل '
                  'التطبيق، ويُعدّ استمرار استخدام التطبيق بعد التحديث '
                  'موافقةً ضمنية على السياسة المُحدَّثة.',
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
                    'لأي استفسار حول الخصوصية',
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
