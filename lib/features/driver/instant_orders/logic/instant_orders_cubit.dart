import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/networking/api_result.dart';
import 'package:graduation_progect/core/notifications/notification_service.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/models/instant_order_model.dart';
import 'package:graduation_progect/features/driver/instant_orders/data/repo/instant_orders_repo.dart';
import 'instant_orders_state.dart';

class InstantOrdersCubit extends Cubit<InstantOrdersState> {
  final InstantOrdersRepo _repo;
  List<InstantOrderModel> currentOrders = [];
  StreamSubscription? _fcmSubscription;

  InstantOrdersCubit(this._repo) : super(const InstantOrdersState.initial()) {
    _listenToFcmOrders();
  }

  void _listenToFcmOrders() {
    _fcmSubscription = NotificationService.instantOrderStreamController.stream.listen((fcmData) {
      try {
        final newOrder = InstantOrderModel.fromFcmPayload(fcmData);
        if (!currentOrders.any((o) => o.userId == newOrder.userId)) {
          currentOrders.insert(0, newOrder);
            _filterAndEmitValidOrders();
        }
      } catch (e) {
        if (kDebugMode) print("❌ فشل تحويل إشعار الطلب הפوري: $e");
      }
    });
  }
  // void _listenToFcmOrders() {
  //   _fcmSubscription = NotificationService.instantOrderStreamController.stream.listen((fcmData) {
  //     try {
  //       final rawPayload = fcmData['notification'] ?? '{}';
  //       final parsedData = jsonDecode(rawPayload);
        
  //       // التحقق من نوع الحدث القادم من الباك إند (يجب التنسيق مع الباك إند لإرسال هذا المتغير)
  //       final String actionType = parsedData['action_type'] ?? 'new_order';

  //       if (actionType == 'cancel_order') {
  //         // في حال كان الحدث هو إلغاء الطلب، نستخرج الـ user_id ونحذفه فوراً
  //         final int canceledUserId = int.tryParse(parsedData['user_id'].toString()) ?? 0;
  //         if (canceledUserId != 0) {
  //           removeOrderLocally(canceledUserId);
  //         }
  //       } else {
  //         // إضافة طلب جديد (الكود الخاص بك)
  //         final newOrder = InstantOrderModel.fromFcmPayload(fcmData);
  //         if (!currentOrders.any((o) => o.userId == newOrder.userId)) {
  //           currentOrders.insert(0, newOrder);
  //           _filterAndEmitValidOrders();
  //         }
  //       }
  //     } catch (e) {
  //       if (kDebugMode) print("❌ فشل معالجة إشعار الطلب الفوري: $e");
  //     }
  //   });
  // }

  Future<void> fetchPendingOrders({bool showLoading = true}) async {
    if (isClosed) return;
    if (showLoading) emit(const InstantOrdersState.loading());

    final result = await _repo.getPendingRequests();
    if (isClosed) return;

    result.when(
      success: (ordersList) {
        currentOrders.clear();
        currentOrders = List.from(ordersList);
        _filterAndEmitValidOrders();
      },
      failure: (error) {
        if (currentOrders.isNotEmpty) {
          _filterAndEmitValidOrders(); 
        } else {
          emit(InstantOrdersState.error(error));
        }
      },
    );
  }

  void removeOrderLocally(int userId) {
    currentOrders.removeWhere((order) => order.userId == userId);
    _filterAndEmitValidOrders();
  }

  Future<bool> respondToRequest(int userId, bool isAccept) async {
    final result = await _repo.respondToRequest(userId: userId, accept: isAccept);
    return result.when(
      success: (message) => true,
      failure: (error) => false,
    );
  }

  void _filterAndEmitValidOrders() {
    final DateTime now = DateTime.now();
    currentOrders.removeWhere((order) {
      if (order.expiresAt.isEmpty) return false;
      
      DateTime expiresAt = DateTime.parse(order.expiresAt).toLocal();
      return expiresAt.isBefore(now) || expiresAt.isAtSameMomentAs(now);
    });

    if (!isClosed) {
      if (currentOrders.isEmpty) {
        emit(const InstantOrdersState.empty());
      } else {
        emit(InstantOrdersState.success(List.from(currentOrders)));
      }
    }
  }

  @override
  Future<void> close() {
    _fcmSubscription?.cancel();
    return super.close();
  }
}