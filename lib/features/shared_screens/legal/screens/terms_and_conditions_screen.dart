import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/features/shared_screens/legal/widgets/legal_section.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
      appBar: AppBar(title: const Text('الشروط والأحكام'), centerTitle: true),
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
              'يقرّ المستخدم، سواء كان عميلاً أم سائقاً، باستخدامه تطبيق '
              'TransNet بموافقته على الشروط والأحكام التالية. يُرجى قراءتها '
              'بعناية قبل إنشاء حساب أو استخدام أي من خدمات التطبيق.',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
            ),
            verticalSpace(20),

            LegalSection(
              number: 1,
              icon: Icons.info_outline_rounded,
              title: 'طبيعة الخدمة',
              body:
                  'يُعدّ TransNet منصة وسيطة تربط بين العملاء الراغبين في '
                  'شحن ونقل البضائع والسائقين المستقلين المتاحين لتنفيذ '
                  'عمليات النقل. لا يمتلك التطبيق أسطول شحن خاصاً به، ولا '
                  'يُعدّ طرفاً في عقد النقل القائم بين العميل والسائق، بل '
                  'يقتصر دوره على تقديم وسيلة تقنية لتسهيل التواصل '
                  'والمطابقة بين الطرفين.',
            ),

            LegalSection(
              number: 2,
              icon: Icons.how_to_reg_outlined,
              title: 'الحساب والتسجيل',
              bullets: const [
                'يجب على المستخدم تقديم معلومات صحيحة ودقيقة عند إنشاء الحساب.',
                'يتحمل المستخدم مسؤولية الحفاظ على سرية بيانات الدخول الخاصة بحسابه.',
                'يُمنع إنشاء أكثر من حساب واحد بذات رقم الهاتف أو البريد الإلكتروني.',
                'يخضع حساب السائق لمراجعة وتفعيل من قِبل إدارة التطبيق قبل السماح له باستقبال الطلبات.',
              ],
            ),

            LegalSection(
              number: 3,
              icon: Icons.local_shipping_outlined,
              title: 'التزامات العميل',
              bullets: const [
                'تقديم وصف دقيق للبضاعة المراد شحنها من حيث النوع والوزن والأبعاد.',
                'عدم شحن مواد ممنوعة أو خطرة أو مخالفة للقانون.',
                'التواجد في نقطتي الاستلام والتسليم بالموعد المتفق عليه، أو تكليف شخص آخر باستلام الشحنة أو تسليمها.',
                'سداد الأجرة المتفق عليها عند إتمام عملية التوصيل.',
              ],
            ),
            
            LegalSection(
              number: 4,
              icon: Icons.warning_amber_rounded,
              title: 'الإقرار بمشروعية البضاعة وإخلاء المسؤولية',
              body:
                  'يقرّ العميل ومالك البضاعة، بمجرد استخدام التطبيق لإنشاء '
                  'طلب شحن، بأن البضاعة المطلوب نقلها مشروعة تماماً، ولا '
                  'تخالف أي قانون أو نظام معمول به، وأنها لا تتضمن أي '
                  'مواد محظورة أو مسروقة أو خطرة أو مخالفة لأحكام القانون '
                  '\n\n'
                  'يتحمّل العميل ومالك البضاعة وحده كامل المسؤولية '
                  'القانونية عن طبيعة البضاعة ومحتواها ومدى مشروعية '
                  'حيازتها ونقلها، ولا تتحمّل إدارة TransNet ولا السائق '
                  'المنفِّذ للشحنة أي مسؤولية عن أي مخالفة قانونية '
                  'متعلقة بالبضاعة المنقولة، باعتبار التطبيق مجرد وسيط '
                  'تقني لا يفحص أو يتحقق من محتوى الشحنات.\n\n'
                  'وفي حال تبيّن أن شحنة ما تحتوي على مواد مخالفة '
                  'للقانون، يحق لإدارة TransNet حظر حساب العميل المعني '
                  'فوراً، والتعاون مع الجهات المختصة إن اقتضى الأمر، '
                  'دون أن يترتب على ذلك أي مسؤولية تقع على عاتق التطبيق.',
            ),

            LegalSection(
              number: 5,
              icon: Icons.person_pin_circle_outlined,
              title: 'التزامات السائق',
              bullets: const [
                'التأكد من صحة ودقة بيانات المركبة المسجَّلة على حسابه.',
                'الالتزام بالمواعيد والمسارات المتفق عليها مع العميل.',
                'التعامل مع البضاعة المنقولة بعناية وعدم التسبب بأي ضرر لها.',
                'تفعيل حالة "متاح" فقط عند القدرة الفعلية على استقبال الطلبات وتنفيذها.',
              ],
            ),

            LegalSection(
              number: 6,
              icon: Icons.payments_outlined,
              title: 'التسعير والدفع',
              body:
                  'يُحدَّد سعر عملية الشحن بالتراضي المباشر بين العميل '
                  'والسائق عبر التطبيق قبل تأكيد الطلب. تفرض إدارة '
                  'TransNet عمولة خدمة بنسبة 15% من قيمة كل عملية شحن '
                  'مكتملة.\n\n'
                  'يتم سداد أجرة النقل يدوياً بشكل مباشر بين العميل '
                  'والسائق، إما نقداً عند تسليم الشحنة أو بأي وسيلة أخرى '
                  'يتفقان عليها فيما بينهما. ولا يوفّر التطبيق حالياً أي '
                  'وسيلة دفع إلكتروني داخلي، ولا يتحمل بالتالي أي مسؤولية '
                  'عن معاملات الدفع التي تتم مباشرة بين الطرفين خارج نطاقه.',
            ),

            LegalSection(
              number: 7,
              icon: Icons.balance_outlined,
              title: 'حدود المسؤولية',
              body:
                  'بصفته منصة وسيطة تقنية، لا يُعدّ TransNet طرفاً في عقد '
                  'النقل القائم بين العميل والسائق، ولا يتحمل أي مسؤولية '
                  'مباشرة عن أي تلف أو فقدان أو تأخير يلحق بالبضاعة أثناء '
                  'عملية النقل، إذ تقع هذه المسؤولية كاملةً على عاتق '
                  'السائق المنفِّذ للشحنة، وفق الاتفاق المباشر القائم '
                  'بينه وبين العميل.\n\n'
                  'ومع ذلك، يحق للعميل الإبلاغ عن السائق من خلال التطبيق '
                  'في حال وقوع أي تلف أو فقدان أو مخالفة أثناء تنفيذ '
                  'الشحنة، وتقوم إدارة TransNet عندئذٍ بالتحقق من البلاغ '
                  'استناداً إلى المعلومات المتاحة لديها (كبيانات الشحنة '
                  'وسجل الحساب وأي أدلة مرفقة)، واتخاذ الإجراء المناسب '
                  'بحق السائق وفق ما تقتضيه هذه الشروط، دون أن يُعدّ ذلك '
                  'تحمّلاً من التطبيق للمسؤولية المالية عن الضرر نفسه.\n\n'
                  'وفي حال رغب العميل بتأمين إضافي على البضاعة المنقولة، '
                  'يجوز له التعاقد بشكل مستقل مع أي شركة تأمين متخصصة '
                  'خارج التطبيق لتغطية قيمة البضاعة أثناء النقل، علماً بأن '
                  'TransNet ليس طرفاً في أي عقد تأمين من هذا النوع، ولا '
                  'يتوسط فيه، ولا يتحمل أي التزام مالي أو قانوني ناشئ '
                  'عنه.\n\n'
                  'كما لا يضمن التطبيق توافر سائقين بشكل دائم أو خلال '
                  'مدة زمنية محددة، ولا يتحمل مسؤولية أي تأخير ناتج عن '
                  'ظروف خارجة عن إرادته.',
            ),

            LegalSection(
              number: 8,
              icon: Icons.block_outlined,
              title: 'حظر أو تجميد الحساب',
              body:
                  'يحق لإدارة TransNet حظر حساب المستخدم أو تجميده، بشكل '
                  'مؤقت أو نهائي، في حال مخالفته لأي من هذه الشروط، أو '
                  'استخدامه التطبيق بشكل احتيالي، أو إساءته لطرف آخر من '
                  'مستخدمي التطبيق، أو تقديمه معلومات غير صحيحة عند '
                  'التسجيل.\n\n'
                  'في الحالات الجسيمة، كالاحتيال أو الإساءة المباشرة '
                  'لمستخدم آخر، يجوز حظر الحساب فوراً دون إشعار مسبق. أما '
                  'في الحالات الأخرى، فيجوز تجميد الحساب مؤقتاً للسائقين '
                  'الذين لم يستوفوا مستحقاتهم المالية.'
                  'مع إمكانية رفع الحظر أو التجميد بعد التأكد من زوال '
                  'سببه أو تصحيح الوضع المخالف.',
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
