import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_cubit.dart';
import 'package:graduation_progect/features/driver/driverShipments/logic/driver_shipments_state.dart';
import 'package:graduation_progect/features/driver/driverShipments/ui/widgets/shipment_item_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/ui/screens/search_shipments_screen.dart';

/// Driver shipment history screen.
/// Uses DriverShipmentsCubit — driver-only, no role check.
class DriverShipmentsScreen extends StatefulWidget {
  const DriverShipmentsScreen({super.key});

  @override
  State<DriverShipmentsScreen> createState() => _DriverShipmentsScreenState();
}

class _DriverShipmentsScreenState extends State<DriverShipmentsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    final cubit = context.read<DriverShipmentsCubit>();
    cubit.getShipments(isReload: true);

    _scrollController.addListener(() {
      final state = cubit.state;
      bool hasReachedMax = false;
      if (state is Success) hasReachedMax = state.hasReachedMax;

      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !cubit.isFetchingMore &&
          !hasReachedMax) {
        cubit.getShipments();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('شحناتي', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          Padding(
            padding:  EdgeInsets.all(12.0.r),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchShipmentsScreen()),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onRefresh: () async =>
            context.read<DriverShipmentsCubit>().getShipments(isReload: true),
        child: BlocBuilder<DriverShipmentsCubit, DriverShipmentsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),

              success: (shipments, hasReachedMax) {
                // ── Empty state ───────────────────────────────────────────────
                if (shipments.isEmpty) {
                  return EmptyStateWidget(
                    title: 'لا توجد شحنات',
                    subTitle: 'لم تقم بأي شحنات بعد.',
                    onRetry: () => context
                        .read<DriverShipmentsCubit>()
                        .getShipments(isReload: true),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: shipments.length + (hasReachedMax ? 0 : 1),
                  itemBuilder: (_, index) {
                    if (index >= shipments.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return ShipmentItemCard(shipment: shipments[index]);
                  },
                );
              },

              error: (error) => ErrorStateWidget(
                message: error.message ?? 'حدث خطأ',
                onRetry: () => context
                    .read<DriverShipmentsCubit>()
                    .getShipments(isReload: true),
              ),

              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
