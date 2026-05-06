import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/extensions.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/routing/routes.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/shared_screens/login/ui/screen/login_screen.dart';
import 'package:graduation_progect/features/shared_screens/onboarding/widgets/activation_steps_list.dart';

class DriverActivationStepsScreen extends StatelessWidget {
  const DriverActivationStepsScreen({super.key});


  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, textAlign: TextAlign.center),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        verticalSpace(40),
                        _buildLogo(context),
                        verticalSpace(24),
                        Text(
                          'خطوات تفعيل حسابك كسائق',
                          style: textTheme.displayMedium?.copyWith(
                            fontSize: 22.sp,
                          ),
                        ),
                        verticalSpace(8),
                        Text(
                          'يرجى اتباع الخطوات التالية لضمان قبول طلبك',
                          style: textTheme.bodyMedium,
                        ),
                        verticalSpace(32),
                        const ActivationStepsList(),
                        verticalSpace(24),
          
                        _buildContactSection(context),
                        
                        verticalSpace(24),
                      ],
                    ),
                  ),
                ),
                verticalSpace(20),
                AppTextButton(
                  text: 'موافق',
                  onPressed: () {
                   context.pushReplacementNamed(Routes.login);
                  },
                ),
                verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'لأي استفسار يمكنك التواصل معنا عبر:',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpace(12),
    
        _buildContactItem(
          context,
          icon: Icons.phone_in_talk,
          label: '0935483845',
          onCopy: () => _copyToClipboard(context, '0935483845', 'تم نسخ رقم الهاتف'),
        ),
        verticalSpace(8),
    
        _buildContactItem(
          context,
          icon: Icons.email_outlined,
          label: 'application.shipments@gmail.com',
          onCopy: () => _copyToClipboard(context, 'application.shipments@gmail.com', 'تم نسخ البريد الإلكتروني'),
        ),
      ],
    );
  }

  Widget _buildContactItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onCopy}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20.r),
          horizontalSpace(12),
       Expanded(
          child: Text(
            label, 
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis, 
          ),
        ),
          IconButton(
            onPressed: onCopy,
            icon: Icon(Icons.copy_rounded, size: 18.r, color:  Theme.of(context).colorScheme.primary,),
            tooltip: 'نسخ',
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/documents.png',
        height: 80.h,
        fit: BoxFit.contain,
      ),
    );
  }
}