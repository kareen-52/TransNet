import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/map_tile_cache_service.dart';
import 'package:graduation_progect/core/networking/map_region_downloader.dart';
import 'package:graduation_progect/core/theming/app_colors.dart';
import 'package:graduation_progect/core/widgets/state_handlers/snackbar_helper.dart';

class OfflineMapScreen extends StatefulWidget {
  const OfflineMapScreen({super.key});

  @override
  State<OfflineMapScreen> createState() => _OfflineMapScreenState();
}

class _OfflineMapScreenState extends State<OfflineMapScreen> {
  int? _downloadingId;
  double _progress = 0;
  bool _isClearing = false;

 
  static const Map<int, String> _names = {
    1: 'دمشق',
    2: 'ريف دمشق',
    3: 'حلب',
    4: 'اللاذقية',
    5: 'حماة',
    6: 'حمص',
    7: 'درعا',
    8: 'القنيطرة',
    9: 'الرقة',
    10: 'دير الزور',
    11: 'الحسكة',
    12: 'إدلب',
    13: 'السويداء',
    14: 'طرطوس',
  };

  Future<void> _download(int id) async {
    if (MapRegionDownloader.isDownloading) return;

    setState(() {
      _downloadingId = id;
      _progress = 0;
    });

    await MapRegionDownloader.downloadGovernorate(
      id,
      minZoom: 11,
      maxZoom: 15,
      onProgress: (p) {
        if (mounted) setState(() => _progress = p.percentage);
      },
    );

    if (mounted) {
      setState(() => _downloadingId = null);
      SnackBarHelper.showSuccess(
        context,
        'تم تحميل خريطة ${_names[id]} بنجاح ✓',
      );
    }
  }

  Future<void> _clearCache() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('مسح كاش الخريطة'),
        content: const Text(
          'سيتم حذف جميع الخرائط المحفوظة. هل أنت متأكد؟',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'مسح',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isClearing = true);
    await MapTileCacheService.clearCache();
    if (mounted) {
      setState(() => _isClearing = false);
      SnackBarHelper.showSuccess(context, 'تم مسح كاش الخريطة');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final cachedCount = MapTileCacheService.cachedTilesCount;
    final cacheMB = MapTileCacheService.cacheSizeMB;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        title: Text(
          'خريطة أوفلاين',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
      ),
      body: Column(
        children: [

          _CacheStatsCard(
            cachedCount: cachedCount,
            cacheMB: cacheMB,
            isClearing: _isClearing,
            onClear: _clearCache,
            surface: surface,
            textPrimary: textPrimary,
            textSecondary: textSecondary,
          ),

          if (_downloadingId != null)
            _DownloadProgressBar(
              progress: _progress,
              name: _names[_downloadingId!] ?? '',
              onCancel: () {
                MapRegionDownloader.cancel();
                setState(() => _downloadingId = null);
              },
            ),


          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: _names.length,
              itemBuilder: (context, index) {
                final id = _names.keys.elementAt(index);
                final name = _names[id]!;
                final isThisDownloading = _downloadingId == id;
                final isAnyDownloading = _downloadingId != null;

                return _GovernorateCard(
                  name: name,
                  isDownloading: isThisDownloading,
                  isDisabled: isAnyDownloading && !isThisDownloading,
                  progress: isThisDownloading ? _progress : 0,
                  surface: surface,
                  textPrimary: textPrimary,
                  textSecondary: textSecondary,
                  onDownload: () => _download(id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CacheStatsCard extends StatelessWidget {
  final int cachedCount;
  final double cacheMB;
  final bool isClearing;
  final VoidCallback onClear;
  final Color surface, textPrimary, textSecondary;

  const _CacheStatsCard({
    required this.cachedCount,
    required this.cacheMB,
    required this.isClearing,
    required this.onClear,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.map_outlined,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الخرائط المحفوظة',
                  style: TextStyle(
                    color: textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$cachedCount tile — ${cacheMB.toStringAsFixed(1)} MB',
                  style: TextStyle(color: textSecondary, fontSize: 11.sp),
                ),
              ],
            ),
          ),
          if (cachedCount > 0)
            isClearing
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.error,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                      size: 22.sp,
                    ),
                    onPressed: onClear,
                    tooltip: 'مسح الكاش',
                  ),
        ],
      ),
    );
  }
}

class _DownloadProgressBar extends StatelessWidget {
  final double progress;
  final String name;
  final VoidCallback onCancel;

  const _DownloadProgressBar({
    required this.progress,
    required this.name,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'جاري تحميل $name... ${(progress * 100).toInt()}%',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onCancel,
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              color: AppColors.primary,
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}

class _GovernorateCard extends StatelessWidget {
  final String name;
  final bool isDownloading;
  final bool isDisabled;
  final double progress;
  final VoidCallback onDownload;
  final Color surface, textPrimary, textSecondary;

  const _GovernorateCard({
    required this.name,
    required this.isDownloading,
    required this.isDisabled,
    required this.progress,
    required this.onDownload,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14.r),
        border: isDownloading
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.40))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_city_rounded,
            color: isDisabled ? AppColors.disabled : AppColors.primary,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'محافظة $name',
              style: TextStyle(
                color: isDisabled ? textSecondary : textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          if (isDownloading)
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            ElevatedButton.icon(
              onPressed: isDisabled ? null : onDownload,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.disabled.withValues(alpha: 0.3),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
                minimumSize: Size(0, 36.h),
              ),
              icon: Icon(Icons.download_rounded, size: 15.sp),
              label: Text(
                'تحميل',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
