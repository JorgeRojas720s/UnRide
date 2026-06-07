part of 'connectivity_bloc.dart';

enum ConnectivityStatus { connected, disconnected, unknown }

class ConnectivityState extends Equatable {
  final ConnectivityStatus status;
  final bool isConnected;

  const ConnectivityState({
    this.status = ConnectivityStatus.disconnected,
    this.isConnected = false,
  });

  const ConnectivityState.unknown() : this();

  const ConnectivityState.disconnected()
    : this(status: ConnectivityStatus.disconnected, isConnected: false);

  const ConnectivityState.connected()
    : this(status: ConnectivityStatus.connected, isConnected: true);

  @override
  List<Object> get props => [status, isConnected];
}
