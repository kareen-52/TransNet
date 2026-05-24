import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';
import 'package:graduation_progect/core/widgets/state_handlers/error_state_widget.dart';
import 'package:graduation_progect/features/driver/driverShipments/ui/widgets/shipment_item_card.dart';
import 'package:graduation_progect/features/shared_screens/shipment_search/ui/screens/search_shipments_screen.dart';
import 'package:graduation_progect/features/user/client_shipments/logic/client_shipments_cubit.dart';
import 'package:graduation_progect/features/user/client_shipments/logic/client_shipments_state.dart';

/// Client shipment history screen.
/// Uses ClientShipmentsCubit — completely isolated from DriverShipmentsCubit.
class ClientShipmentsScreen extends StatefulWidget {
  const ClientShipmentsScreen({super.key});

  @override
  State<ClientShipmentsScreen> createState() => _ClientShipmentsScreenState();
}

class _ClientShipmentsScreenState extends State<ClientShipmentsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    final cubit = context.read<ClientShipmentsCubit>();
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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchShipmentsScreen()),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        onRefresh: () =>
            context.read<ClientShipmentsCubit>().getShipments(isReload: true),
        child: BlocBuilder<ClientShipmentsCubit, ClientShipmentsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),

              success: (shipments, hasReachedMax) {
                if (shipments.isEmpty) {
                  return EmptyStateWidget(
                    title: 'لا توجد شحنات',
                    subTitle: 'لم تقم بأي شحنات بعد.',
                    onRetry: () => context
                        .read<ClientShipmentsCubit>()
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
                    .read<ClientShipmentsCubit>()
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
