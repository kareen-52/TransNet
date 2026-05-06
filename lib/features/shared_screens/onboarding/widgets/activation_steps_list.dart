import 'package:flutter/material.dart';
import 'package:graduation_progect/features/shared_screens/onboarding/widgets/step-time_line_item.dart';

class ActivationStepsList extends StatelessWidget {
  const ActivationStepsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepTimelineItem(
          title: 'زيارة مقر الشركة',
          description: 'تفضل بزيارة مقرنا في جرمانا، شارع الروضة.',
          isLast: false,
        ),
        StepTimelineItem(
          title: 'المستندات المطلوبة',
          description:
              'الهوية، رخصة القيادة، رخصة المركبة، لا حكم عليه، اوراق السيارة، وصورة شخصية.',
          isLast: false,
        ),
        StepTimelineItem(
          title: 'معاينة المركبة وانشاء الحساب',
          description: 'سنتحقق من حالة المركبة في الموقع وانشاء حسابك فوراً.',
          isLast: false,
        ),
        StepTimelineItem(
          title: 'تفعيل الحساب',
          description: 'قم بتسجل الدخول عبر التطبيق وتفعيل حسابك فوراً.',
          isLast: true,
        ),
      ],
    );
  }
}
