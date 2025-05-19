part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  authenticatedWithVehicle,
  unauthenticated,
  unknown,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this();

  const AuthenticationState.authenticated(User user)
    : this(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
    : this(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.authenticatedWithVehicle(User user)
    : this(status: AuthenticationStatus.authenticatedWithVehicle, user: user);

  @override
  List<Object?> get props => [status, user];
}
