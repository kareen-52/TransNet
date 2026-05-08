// ============================================================
// lib/core/bloc/app_bloc_observer.dart
// ============================================================

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('══════════════════════════════════════');
      debugPrint('[BlocObserver] ${bloc.runtimeType} ERROR:');
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
      debugPrint('══════════════════════════════════════');
    }
    // TODO: في Production أرسل لـ Firebase Crashlytics:
    // FirebaseCrashlytics.instance.recordError(error, stackTrace,
    //   information: [DiagnosticsNode.message('Bloc: ${bloc.runtimeType}')]);
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
