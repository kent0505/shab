import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_event.dart';

class InternetBloc extends Bloc<InternetEvent, bool> {
  final _connectivity = Connectivity();

  InternetBloc() : super(true) {
    on<InternetEvent>(
      (event, emit) => switch (event) {
        CheckInternet() => _checkInternet(event, emit),
        ChangeInternet() => changeInternet(event, emit),
      },
    );
  }

  void _checkInternet(
    CheckInternet event,
    Emitter<bool> emit,
  ) {
    _connectivity.onConnectivityChanged.listen((result) {
      final connected = result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi);

      add(ChangeInternet(connected: connected));
    });
  }

  void changeInternet(
    ChangeInternet event,
    Emitter<bool> emit,
  ) {
    emit(event.connected);
  }
}
