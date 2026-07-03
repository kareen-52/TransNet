import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/constants.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/helpers/sharedpreference.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  String _role = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final role = await SharedPrefHelper.getString(SharedPrefKeys.userRole);
    if (mounted) {
      setState(() {
        _role = role;
        _isLoading = false;
      });
    }
  }

  List<Map<String, String>> get _clientFaqs => [
    {
      'q': 'كيف أنشئ إعلاناً جديداً؟',
      'a':
          'انتقل إلى صفحة الإعلانات من الشريط السفلي، ثم اضغط على زر "إعلان جديد"، حدد محافظة ونقطة البداية من الخريطة، ثم محافظة ونقطة الوصول، اضغط "التالي"، أدخل ماهية الغرض ووزنه وأبعاده وآخر موعد للشحن، اضغط "التالي"، ثم انشر الإعلان بالسعر المقترح أو عدّله وانشره بالسعر المعدّل.',
    },
    {
      'q': 'كيف أنشئ طلباً فورياً؟',
      'a':
          'انتقل إلى الشاشة الرئيسية واضغط على زر "إنشاء طلب"، حدد نقطة البداية من خلال اختيار المحافظة والموقع، ثم نقطة النهاية، أدخل وصف الغرض والوزن والأبعاد (الطول والعرض والارتفاع)، راجع الطلب، ثم اختر السائق المناسب وانتظر الرد.',
    },
    {
      'q': 'كيف أقيّم السائق بعد الشحنة؟',
      'a':
          'اذهب إلى تبويبة "السجلات" من الشريط السفلي، اختر الشحنة التي تريد تقييم السائق المسؤول عنها، اضغط عليها للدخول إلى تفاصيلها، ثم انزل للأسفل واضغط على زر "تقييم السائق" حدد عدد النجوم التتي تريد واكتب رأيك ثم اضغط على زر إرسال التقييم.',
    },
    {
      'q': 'كيف أعدّل اسمي أو رقم هاتفي؟',
      'a':
          'انتقل إلى البروفايل من خلال تبويب "الحساب" في الشريط السفلي. لتعديل الاسم: اضغط على أيقونة التعديل بجانب الاسم وعدّله واحفظه. لتعديل الرقم: اضغط على أيقونة التعديل بجانب الرقم وعدّله واحفظه.',
    },
    {
      'q': 'كيف أبلّغ عن سائق؟',
      'a':
          'اذهب إلى صفحة "السجلات" من الشريط السفلي، اختر الشحنة المرتبطة بالسائق، اضغط عليها، ومن قسم الأطراف اضغط على زر "الإبلاغ عن السائق"، اكتب سبب الإبلاغ والتفاصيل ثم اضغط إرسال الإبلاغ.',
    },
    {
      'q': 'كيف أغيّر كلمة المرور؟',
      'a':
          'انتقل إلى البروفايل واضغط على "تسجيل الخروج"، ستنتقل إلى شاشة تسجيل الدخول، اضغط "نسيان كلمة المرور"، أدخل بريدك الإلكتروني، أدخل الرمز المكوّن من 6 أرقام الذي سيصلك على بريدك، أدخل كلمة المرور الجديدة، ثم عد لتسجيل الدخول.',
    },
    {
      'q': 'كيف أتواصل مع فريق الدعم؟',
      'a':
          'يمكنك التواصل معنا عبر الواتساب أو الاتصال المباشر أو البريد الإلكتروني من خلال قسم "تواصل معنا" في هذه الصفحة.',
    },
  ];

  List<Map<String, String>> get _driverFaqs => [
    {
      'q': 'كيف أغيّر حالتي إلى متاح أو غير متاح؟',
      'a':
          'انتقل إلى الصفحة الرئيسية واضغط على كبسة "متاح / غير متاح" لتبديل حالتك.',
    },
    {
      'q': 'كيف أتعامل مع طلب فوري؟',
      'a':
          'اذهب إلى الصفحة الرئيسية وتأكد من أن حالتك "متاح"، تصفّح الطلبات الفورية إن وُجدت، ثم اقبل أو ارفض الطلب.',
    },
    {
      'q': 'كيف أقدّم عرضاً على إعلان؟',
      'a':
          'يجب أن تكون حالتك "غير متاح" أولاً، من الشاشة الرئيسية انزل إلى قسم الإعلانات، اختر الإعلان المناسب، اضغط "عرض التفاصيل وتقديم عرض"، اقرأ التفاصيل الكاملة للإعلان ثم اضغط على زر "تقديم عرض"، اختر التاريخ والسعر المناسبَين ضمن المدة والسعر المطلوبَين، ثم اضغط "تقديم عرض على الإعلان".',
    },
    {
      'q': 'كيف أطّلع على أرباحي؟',
      'a':
          'انتقل إلى البروفايل من خلال تبويب "الحساب" في الشريط السفلي، ثم اضغط على "أرباحي".',
    },
    {
      'q': 'كيف أضيف أو أحذف خط نقل؟',
      'a':
          'انتقل إلى البروفايل من تبويب "الحساب"، اضغط على "خطوط النقل". لإضافة خط: اضغط "إضافة" واختر المحافظة. لحذف خط: اضغط على أيقونة سلة المهملات بجانب المحافظة المراد حذفها.',
    },
    {
      'q': 'كيف أعدّل رقم هاتفي؟',
      'a':
          'انتقل إلى البروفايل من تبويب "الحساب"، اضغط على أيقونة التعديل بجانب الرقم، عدّله واحفظه.',
    },
    {
      'q': 'كيف أبلّغ عن مشكلة في شحنة؟',
      'a':
          'اذهب إلى صفحة "السجلات" من الشريط السفلي، اختر الشحنة المرادة، ومن قسم الأطراف اضغط على زر "الإبلاغ عن العميل"، اكتب سبب الإبلاغ والتفاصيل ثم اضغط إرسال الإبلاغ.',
    },
    {
      'q': 'كيف أغيّر كلمة المرور؟',
      'a':
          'انتقل إلى البروفايل واضغط على "تسجيل الخروج"، ستنتقل إلى شاشة تسجيل الدخول، اضغط "نسيان كلمة المرور"، أدخل بريدك الإلكتروني، أدخل الرمز المكوّن من 6 أرقام الذي سيصلك على بريدك، أدخل كلمة المرور الجديدة، ثم عد لتسجيل الدخول.',
    },
    {
      'q': 'كيف أتواصل مع فريق الدعم؟',
      'a':
          'يمكنك التواصل معنا عبر الواتساب أو الاتصال المباشر أو البريد الإلكتروني من خلال قسم "تواصل معنا" في هذه الصفحة.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final isDriver = _role == 'driver';
    final faqs = isDriver ? _driverFaqs : _clientFaqs;

    return Scaffold(
      appBar: AppBar(title: const Text('المساعدة والدعم'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            _buildSection(
              context,
              'الأسئلة الشائعة',
              Icons.help_outline,
              faqs
                  .map((item) => _buildFaqItem(context, item['q']!, item['a']!))
                  .toList(),
            ),
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
          const Divider(),
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
          const Divider(),
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
            'application.shipments@gmail.com',
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
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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

    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanNumber');

    try {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى تثبيت تطبيق واتساب أولاً'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
