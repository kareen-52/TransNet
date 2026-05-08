import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/logic/search_shipments_cubit.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/logic/search_shipments_state.dart';
import 'package:graduation_progect/features/shared_screens/shipment_details/ui/screens/shipment_details_screen.dart';
import 'package:intl/intl.dart';

class SearchShipmentsScreen extends StatelessWidget {
  const SearchShipmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // نوفر الكيوبت هنا بنفسنا
    return BlocProvider<SearchShipmentsCubit>(
      create: (_) =>  getIt<SearchShipmentsCubit>(),
      child: const _SearchShipmentsBody(),
    );
  }
}

class _SearchShipmentsBody extends StatefulWidget {
  const _SearchShipmentsBody();

  @override
  State<_SearchShipmentsBody> createState() => _SearchShipmentsBodyState();
}

class _SearchShipmentsBodyState extends State<_SearchShipmentsBody> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme,
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final formatted = DateFormat('yyyy-MM-dd').format(picked);
      if (isStart) {
        _startDateController.text = formatted;
      } else {
        _endDateController.text = formatted;
      }
    }
  }

  void _performSearch() {
    if (_formKey.currentState!.validate()) {
      context.read<SearchShipmentsCubit>().search(
            startDate: _startDateController.text.trim(),
            endDate: _endDateController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('بحث عن شحنة'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'من تاريخ',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                      onTap: () => _selectDate(isStart: true),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'إلى تاريخ',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                      onTap: () => _selectDate(isStart: false),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: _performSearch,
              icon: const Icon(Icons.search),
              label: const Text('بحث'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 24.h),
            BlocBuilder<SearchShipmentsCubit, SearchShipmentsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => Center(
                    child: CircularProgressIndicator(color: theme.colorScheme.primary),
                  ),
                  empty: () => Container(
                    padding: EdgeInsets.symmetric(vertical: 60.h),
                    child: Column(
                      children: [
                        Icon(Icons.inbox_outlined, size: 80.sp, color: Colors.grey.shade400),
                        SizedBox(height: 16.h),
                        Text(
                          'لا توجد شحنات في هذا النطاق الزمني',
                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  error: (error) => Container(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 64.sp, color: Colors.red.shade300),
                        SizedBox(height: 16.h),
                        Text(
                          error.message ?? 'حدث خطأ',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
                        ),
                      ],
                    ),
                  ),
                  loaded: (shipments) {
                    return Column(
                      children: [
                        for (final shipment in shipments)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Card(
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ShipmentDetailsScreen(
                                        shipmentId: shipment.id ?? 0,
                                      ),
                                    ),
                                  );
                                },
                                leading: Icon(Icons.local_shipping, color: theme.colorScheme.primary),
                                title: Text(
                                  'شحنة ${shipment.shipmentNumber ?? ''}',
                                  style: theme.textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  '${shipment.startGovernorate ?? ''} → ${shipment.endGovernorate ?? ''}',
                                  style: theme.textTheme.bodySmall,
                                ),
                                trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}