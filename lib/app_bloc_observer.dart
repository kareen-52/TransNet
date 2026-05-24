import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('[BlocObserver] ${bloc.runtimeType} ERROR:');
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      debugPrint(
        '[BlocObserver] ${bloc.runtimeType}: '
        '${transition.currentState.runtimeType} → '
        '${transition.nextState.runtimeType}',
      );
    }
    super.onTransition(bloc, transition);
  }
}
