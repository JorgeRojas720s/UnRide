import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc() : super(const ConnectivityState.unknown()) {
    
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results){
        final isConnected = results.contains(ConnectivityResult.mobile) || results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.ethernet);

        add(ConnectivityChanged(isConnected));
    });
 
      on<ConnectivityChanged>((event, emit){
        if(event.isConnected){
          emit(ConnectivityState.connected());
        }else{
          emit(ConnectivityState.disconnected());
        }
      } );

  }
  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
