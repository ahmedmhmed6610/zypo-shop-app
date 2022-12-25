import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_event.dart';
import 'network_state.dart';
class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(ConnectionInitial());

  late StreamSubscription _subscription;

  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is ListenConnection) {
      _subscription =InternetConnectionChecker().onStatusChange.listen((status) {
        add(ConnectionChanged(status ==  InternetConnectionStatus.connected
            ? ConnectionSuccess()
            : ConnectionFailure()));
       // print(status);
      });
    }
    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
