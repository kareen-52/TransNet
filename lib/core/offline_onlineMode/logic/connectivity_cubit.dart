import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_progect/core/offline_onlineMode/connectivity_helper.dart';
import 'package:graduation_progect/core/offline_onlineMode/logic/connectivity_state.dart';


class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityState.online()) {

    ConnectivityHelper.onConnectivityChange.listen((isOnline) {
      if (isOnline) {
        emit(const ConnectivityState.online());
      } else {
        emit(const ConnectivityState.offline());
      }
    });
  }

  @override
  Future<void> close() {
    ConnectivityHelper.dispose();
    return super.close();
  }
}