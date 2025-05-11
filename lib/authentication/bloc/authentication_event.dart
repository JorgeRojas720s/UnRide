part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];//!Es para saber si dos instacias son iaguales viene de equatable
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User user; //!Este es el user que viene del stream de firebase.

  @override
  List<Object> get props => [user]; //!Aqui esta user, tons 2 eventos con distointos user no serán iguales
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
