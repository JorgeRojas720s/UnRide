part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => []; //!Es para saber si dos instacias son iaguales viene de equatable
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user; //!Este es el user que viene del stream de firebase.

  const AuthenticationUserChanged(this.user);

  @override
  List<Object> get props => [user]; //!Aqui esta user, tons 2 eventos con distointos user no serán iguales
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

//!Registrar al user normal
class AuthenticationUserRegister extends AuthenticationEvent {
  final String identification;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String password;
  final String photoURL;

  AuthenticationUserRegister({
    required this.identification,
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.password,
    required this.photoURL,
  });

  @override
  List<Object> get props => [];
}

// //!Registrar al user normal
// class UserRegister extends AuthenticationEvent {
//   final String identification;
//   final String name;
//   final String surname;
//   final String email;
//   final String password;
//   final String photoURL;

//   UserRegister({
//     required this.identification,
//     required this.name,
//     required this.surname,
//     required this.email,
//     required this.password,
//     required this.photoURL,
//   });

//   @override
//   List<Object> get props => [];
// }
