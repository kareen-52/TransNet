import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/shared_screens/report_user/logic/report_cubit.dart';
import 'package:graduation_progect/features/shared_screens/report_user/logic/report_state.dart';

class ReportDialog extends StatefulWidget {
  final int reportedId;
  final String role;

  const ReportDialog({super.key, required this.reportedId, required this.role});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ReportCubit, ReportState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (msg) {
            Navigator.pop(context);
            SnackBarHelper.showSuccess(context, msg);
          },
          error: (err) {
            Navigator.pop(context);
            SnackBarHelper.showError(context, err);
          },
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        backgroundColor: theme.colorScheme.surface,
        insetPadding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.report_problem_rounded,
                          color: Theme.of(context).colorScheme.error,
                          size: 28.sp,
                        ),
                        horizontalSpace(8),
                        Text(
                          'الإبلاغ عن ${widget.role}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                Text(
                  'نأخذ جميع البلاغات على محمل الجد وسيتم مراجعتها لحماية حقوقك.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),
                verticalSpace(24),

                Text(
                  'سبب البلاغ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
                verticalSpace(8),
                AppTextFormField(
                  controller: _typeController,
                  hintText: "مثال: تأخير التوصيل, سوء معاملة...",
                ),
                verticalSpace(16),

                Text(
                  'التفاصيل (الرجاء الشرح بوضوح)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
                verticalSpace(8),
                AppTextFormField(
                  controller: _descController,
                  maxLines: 4,
                  hintText: 'اكتب هنا الشرح بالتفصيل...',
                ),
                verticalSpace(32),

                BlocBuilder<ReportCubit, ReportState>(
                  builder: (context, state) {
                    final isLoading = state == const ReportState.loading();
                    return AppTextButton(
                      text: 'إرسال الإبلاغ',
                      backgroundColor: Theme.of(context).colorScheme.error,
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<ReportCubit>().submitReport(
                          reportedId: widget.reportedId,
                          type: _typeController.text,
                          description: _descController.text,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
