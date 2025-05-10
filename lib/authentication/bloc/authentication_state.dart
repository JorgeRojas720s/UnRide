part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  //!Segun el estado de la autenticacion, se le asigna un valor al constructor
  const AuthenticationState.unknown() : this(); //! Constructor por defecto

  const AuthenticationState.authenticated(User user)
    : this(
        status: AuthenticationStatus.authenticated,
        user: user,
      ); //! Constructor para el estado autenticado

  const AuthenticationState.unauthenticated()
    : this(
        status: AuthenticationStatus.unauthenticated,
      ); //! Constructor para el estado no autenticado

  @override
  List<Object?> get props => throw UnimplementedError();
}
