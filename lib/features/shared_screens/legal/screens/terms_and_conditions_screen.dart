import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/shared_screens/legal/widgets/legal_section.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
        title: const Text('الشروط والأحكام'),
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
              icon: Icons.gavel_rounded,
            ),

            Text(
              'باستخدامك لتطبيق TransNet كعميل أو كسائق، فإنك توافق على '
              'الشروط والأحكام التالية. يرجى قراءتها بعناية قبل إنشاء '
              'حساب أو استخدام أي من خدمات التطبيق.',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
            ),
            verticalSpace(20),

            LegalSection(
              number: 1,
              icon: Icons.info_outline_rounded,
              title: 'طبيعة الخدمة',
              body:
                  'TransNet هو منصة وسيطة تربط بين العملاء الراغبين بشحن '
                  'ونقل البضائع والسائقين المستقلين المتوفرين لتنفيذ '
                  'عمليات النقل داخل محافظات سوريا. التطبيق لا يملك '
                  'أسطول شحن خاص به ولا يعتبر طرفاً في عقد النقل نفسه، '
                  'بل وسيط تقني لتسهيل التواصل والمطابقة بين الطرفين.',
            ),

            LegalSection(
              number: 2,
              icon: Icons.how_to_reg_outlined,
              title: 'الحساب والتسجيل',
              bullets: const [
                'يجب تقديم معلومات صحيحة ودقيقة عند إنشاء الحساب.',
                'أنت مسؤول عن الحفاظ على سرية بيانات الدخول (كلمة المرور) الخاصة بحسابك.',
                'يُمنع إنشاء أكثر من حساب واحد بنفس رقم الهاتف أو البريد الإلكتروني.',
                'حساب السائق يخضع لمراجعة وتفعيل قبل السماح باستقبال طلبات.',
              ],
            ),

            LegalSection(
              number: 3,
              icon: Icons.local_shipping_outlined,
              title: 'التزامات العميل',
              bullets: const [
                'تقديم وصف دقيق للبضاعة المراد شحنها (النوع، الوزن، الأبعاد).',
                'عدم شحن مواد ممنوعة أو خطرة أو غير قانونية.',
                'التواجد بنقطتي الاستلام والتسليم بالوقت المتفق عليه، أو تعيين شخص بديل لاستلام/تسليم الشحنة.',
                'دفع السعر المتفق عليه عند اكتمال عملية التوصيل.',
              ],
            ),

            LegalSection(
              number: 4,
              icon: Icons.person_pin_circle_outlined,
              title: 'التزامات السائق',
              bullets: const [
                'التأكد من صحة ودقة بيانات المركبة المسجّلة على حسابه.',
                'الالتزام بالمواعيد والمسارات المتفق عليها مع العميل.',
                'التعامل بحرص مع البضاعة المنقولة وعدم إلحاق ضرر بها.',
                'تفعيل حالة "متاح" فقط عند القدرة الفعلية على استقبال طلبات وتنفيذها.',
              ],
            ),

            LegalSection(
              number: 5,
              icon: Icons.payments_outlined,
              title: 'التسعير والدفع',
              body:
                  '🔸 [هاد البند لازم تحدديه بدقة حسب آلية عملكم الفعلية]: '
                  'كيف يتم تحديد السعر (نطاق سعري مقترح يقدّم عليه '
                  'السائقون)، وطريقة الدفع (نقداً عند التسليم؟ إلكترونياً '
                  'داخل التطبيق؟)، وهل يأخذ التطبيق عمولة من السائق أو '
                  'العميل، وبأي نسبة.',
            ),

            LegalSection(
              number: 6,
              icon: Icons.cancel_outlined,
              title: 'الإلغاء',
              body:
                  '🔸 [حددي هون]: خلال أي مدة يحق للعميل أو السائق إلغاء '
                  'الطلب/العرض بدون رسوم، وهل يوجد رسوم أو تأثير على '
                  'تقييم الحساب عند الإلغاء المتكرر بعد قبول الطرفين.',
            ),

            LegalSection(
              number: 7,
              icon: Icons.balance_outlined,
              title: 'حدود المسؤولية',
              body:
                  '🔸 [هاد من أهم البنود قانونياً، يفضّل مراجعته مع مختص]: '
                  'بما إنو TransNet منصة وسيطة، فهو غير مسؤول بشكل '
                  'مباشر عن أي تلف أو فقدان أو تأخير يلحق بالبضاعة أثناء '
                  'النقل، وتقع هذه المسؤولية على عاتق السائق المنفّذ '
                  'للشحنة، إلا بالحدود التي يحددها القانون المعمول به. '
                  'كما لا يضمن التطبيق توفر سائقين بشكل دائم أو خلال '
                  'مدة زمنية معينة.',
            ),

            LegalSection(
              number: 8,
              icon: Icons.block_outlined,
              title: 'إيقاف أو إنهاء الحساب',
              body:
                  'يحق لإدارة TransNet إيقاف أو حذف أي حساب يخالف هذه '
                  'الشروط، أو يُستخدم لأغراض احتيالية، أو يسيء لطرف آخر '
                  'من مستخدمي التطبيق، دون إشعار مسبق في الحالات '
                  'الجسيمة.',
            ),

            LegalSection(
              number: 9,
              icon: Icons.policy_outlined,
              title: 'القانون الحاكم',
              body:
                  '🔸 تخضع هذه الشروط وتُفسَّر وفقاً لقوانين الجمهورية '
                  'العربية السورية [أكّدي هاد البند]، وأي نزاع ينشأ عن '
                  'استخدام التطبيق يُحال إلى الجهات القضائية المختصة.',
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
                    'لأي استفسار حول الشروط والأحكام',
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
