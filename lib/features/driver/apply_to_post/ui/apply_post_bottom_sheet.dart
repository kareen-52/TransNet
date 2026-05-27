import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';
import 'package:graduation_progect/features/driver/apply_to_post/logic/apply_to_post_cubit.dart';
import 'package:graduation_progect/features/driver/apply_to_post/logic/apply_to_post_state.dart';

class ApplyPostBottomSheet extends StatefulWidget {
  final int postId;
  final num minPrice;
  final num maxPrice;
  final String lastDate;

  const ApplyPostBottomSheet({
    super.key,
    required this.postId,
    required this.minPrice,
    required this.maxPrice,
    required this.lastDate, 
  });

  @override
  State<ApplyPostBottomSheet> createState() => _ApplyPostBottomSheetState();
}

class _ApplyPostBottomSheetState extends State<ApplyPostBottomSheet> {
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  DateTime? _selectedDate;
  String? _dateError; 

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  String _format(num n) => n.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');


  Future<void> _pickDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    

    DateTime maxAllowedDate;
    try {
      maxAllowedDate = DateTime.parse(widget.lastDate);
      if (maxAllowedDate.isBefore(today)) {
        maxAllowedDate = today;
      }
    } catch (e) {
      maxAllowedDate = today.add(const Duration(days: 30));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? today,
      firstDate: today,
      lastDate: maxAllowedDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.secondary, 
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<ApplyToPostCubit, ApplyToPostState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (msg) {
            Navigator.pop(context);
            SnackBarHelper.showSuccess(context, msg);
          },
          error: (err) {
            SnackBarHelper.showError(context, err.getAllErrorMessages());
            // Navigator.pop(context);
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: bottomInset),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                verticalSpace(24),
                Text('تقديم عرض توصيل',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                verticalSpace(8),
                Text(
                  'أدخل السعر الذي تطلبه لتوصيل هذه الشحنة، وحدد تاريخ التسليم المقترح (يجب ألا يتجاوز أقصى موعد للإعلان).',
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.5),
                ),
                verticalSpace(20),


                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline_rounded,
                          color: theme.colorScheme.secondary, size: 18.sp),
                      horizontalSpace(8),
                      Text(
                        'النطاق: ${_format(widget.minPrice)} - ${_format(widget.maxPrice)} ل.س',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
                verticalSpace(24),


                GestureDetector(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'تاريخ التوصيل الفعلي',
                      errorText: _dateError,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: theme.colorScheme.primary),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'اضغط لاختيار التاريخ'
                              : _selectedDate!.toString().split(' ')[0],
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: _selectedDate == null ? Colors.grey : theme.colorScheme.onSurface,
                            fontWeight: _selectedDate == null ? FontWeight.normal : FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.calendar_month_rounded, color: theme.colorScheme.primary, size: 20.sp),
                      ],
                    ),
                  ),
                ),
                verticalSpace(16),


                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'سعرك المطلوب',
                    suffixText: 'ل.س',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'يرجى إدخال السعر';
                    final price = double.tryParse(value);
                    if (price == null || price <= 0) return 'سعر غير صالح';
                    if (price < widget.minPrice) return 'لا يمكن أن يكون أقل من ${_format(widget.minPrice)}';
                    if (price > widget.maxPrice) return 'لا يمكن أن يتجاوز ${_format(widget.maxPrice)}';
                    return null;
                  },
                ),
                verticalSpace(32),

                // زر التقديم
                BlocBuilder<ApplyToPostCubit, ApplyToPostState>(
                  builder: (context, state) {
                    final isLoading = state == const ApplyToPostState.loading();
                    return AppTextButton(
                      backgroundColor: theme.colorScheme.secondary,
                      text: 'إرسال العرض',
                      isLoading: isLoading,
                      onPressed: () {

                        if (_selectedDate == null) {
                          setState(() => _dateError = 'يرجى اختيار تاريخ التوصيل');
                          return;
                        }


                        if (_formKey.currentState!.validate()) {
                          final price = double.parse(_priceController.text);
                          final dateString = _selectedDate!.toString().split(' ')[0];
                          
                          context.read<ApplyToPostCubit>().submitApplication(
                                widget.postId,
                                price,
                                dateString,
                              );
                        }
                      },
                    );
                  },
                ),
                verticalSpace(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}