import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
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
  final TextEditingController _descController = TextEditingController();
  final List<String> _reportTypes = [
    'سلوك غير لائق',
    'تأخير متعمد',
    'احتيال أو طلب مبالغ إضافية',
    'مركبة / بضاعة غير مطابقة',
    'أخرى'
  ];
  late String _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = _reportTypes.first;
  }

  @override
  void dispose() {
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
            SnackBarHelper.showError(context, err);
          },
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
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
                        Icon(Icons.report_problem_rounded, color: AppColors.error, size: 28.sp),
                        horizontalSpace(8),
                        Text('الإبلاغ عن ${widget.role}', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.error)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close_rounded, color: Colors.grey, size: 24.sp),
                    ),
                  ],
                ),
                verticalSpace(12),
                Text(
                  'نأخذ جميع البلاغات على محمل الجد وسيتم مراجعتها من قبل الإدارة لحماية حقوقك.',
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.5, color: Colors.grey.shade600),
                ),
                verticalSpace(24),


                Text('سبب البلاغ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
                verticalSpace(8),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                  items: _reportTypes.map((t) => DropdownMenuItem(value: t, child: Text(t, style: TextStyle(fontSize: 13.sp)))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedType = val);
                  },
                ),
                verticalSpace(16),

                Text('التفاصيل (الرجاء الشرح بوضوح)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp)),
                verticalSpace(8),
                TextField(
                  controller: _descController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'اكتب هنا ما حدث معك بالتفصيل...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: AppColors.error)),
                  ),
                ),
                verticalSpace(32),

                BlocBuilder<ReportCubit, ReportState>(
                  builder: (context, state) {
                    final isLoading = state == const ReportState.loading();
                    return AppTextButton(
                      text: 'إرسال البلاغ',
                      backgroundColor: AppColors.error,
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<ReportCubit>().submitReport(
                              reportedId: widget.reportedId,
                              type: _selectedType,
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