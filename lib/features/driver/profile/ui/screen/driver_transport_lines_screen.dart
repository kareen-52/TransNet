import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/di/dependency_injection.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/features/driver/profile/data/models/profile_response.dart';
import 'package:graduation_progect/features/driver/profile/logic/profile_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';
import 'package:graduation_progect/features/user/create_shipment/data/repos/create_shipment_repo.dart';

class TransportLinesScreen extends StatefulWidget {
  final List<GovernorateData>? governorates;
  final ProfileCubit profileCubit;

  const TransportLinesScreen({
    super.key,
    required this.governorates,
    required this.profileCubit,
  });

  @override
  State<TransportLinesScreen> createState() => _TransportLinesScreenState();
}

class _TransportLinesScreenState extends State<TransportLinesScreen> {
  List<GovernorateModel> _allGovernorates = [];
  bool _isLoadingGovernorates = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('خطوط النقل'), centerTitle: true),
      body: widget.governorates == null || widget.governorates!.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: widget.governorates!.length,
              itemBuilder: (context, index) {
                final governorate = widget.governorates![index];
                return _buildGovernorateCard(context, governorate);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddGovernorateDialog,
        icon: Icon(Icons.add, size: 24.sp),
        label: Text('إضافة خط نقل', style: TextStyle(fontSize: 14.sp)),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildGovernorateCard(
    BuildContext context,
    GovernorateData governorate,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primary.withOpacity(0.1),
          child: Icon(Icons.location_city, color: colorScheme.primary),
        ),
        title: Text(
          governorate.name ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('محافظة تغطية'),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: colorScheme.error,
            size: 22.sp,
          ),
          onPressed: () => _confirmDelete(context, governorate),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.route_outlined,
            size: 80.sp,
            color: colorScheme.onSurfaceVariant,
          ),
          verticalSpace(16),
          Text(
            'لا توجد خطوط نقل',
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          verticalSpace(8),
          Text(
            'اضغط على زر + لإضافة خط نقل جديد',
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddGovernorateDialog() async {
    if (_allGovernorates.isEmpty && !_isLoadingGovernorates) {
      setState(() => _isLoadingGovernorates = true);

      _showLoadingDialog();

      try {
        final repo = getIt<CreateShipmentRepo>();
        final result = await repo.getGovernorates();

        if (mounted) Navigator.pop(context);
        result.when(
          success: (governorates) {
            setState(() {
              _allGovernorates = governorates;
              _isLoadingGovernorates = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تحميل المحافظات بنجاح'),
                backgroundColor: Colors.green,
              ),
            );

            _showGovernoratesPicker();
          },
          failure: (error) {
            setState(() => _isLoadingGovernorates = false);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? 'فشل تحميل المحافظات'),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      } catch (e) {
        if (mounted) Navigator.pop(context);

        setState(() => _isLoadingGovernorates = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ أثناء تحميل المحافظات'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      _showGovernoratesPicker();
    }
  }

  void _showGovernoratesPicker() {
    final currentGovernoratesIds =
        widget.governorates?.map((g) => g.id).toSet() ?? {};
    final availableGovernorates = _allGovernorates
        .where((gov) => !currentGovernoratesIds.contains(gov.id))
        .toList();

    if (availableGovernorates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لقد أضفت جميع المحافظات المتاحة')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('اختر محافظة للإضافة'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400.h,
            child: ListView.builder(
              itemCount: availableGovernorates.length,
              itemBuilder: (context, index) {
                final gov = availableGovernorates[index];
                return ListTile(
                  title: Text(gov.name ?? ''),
                  leading: Icon(
                    Icons.add_location_alt,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(dialogContext);
                    _addGovernorate(gov.id!);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _addGovernorate(int govId) async {
    _showLoadingDialog();

    final success = await widget.profileCubit.addGovernorate(govId);

    if (mounted) Navigator.pop(context);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إضافة خط النقل بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('فشل إضافة خط النقل'),
          backgroundColor: Colors.red,
        ),
      );
    }

    Navigator.pop(context);
  }

  void _confirmDelete(BuildContext context, GovernorateData governorate) {
    // 🔥 منع حذف آخر خط نقل
    if (widget.governorates != null && widget.governorates!.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'لا يمكن حذف آخر خط نقل. يجب أن يبقى خط واحد على الأقل',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('حذف خط نقل'),
          content: Text('هل أنت متأكد من حذف محافظة "${governorate.name}"؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );

                final success = await widget.profileCubit.removeGovernorate(
                  governorate.id!,
                );

                if (mounted) Navigator.pop(context);

                if (!mounted) return;

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم حذف خط النقل بنجاح'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('فشل حذف خط النقل'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                Navigator.pop(context);
              },
              child: const Text('حذف'),
            ),
          ],
        ),
      ),
    );
  }
}
