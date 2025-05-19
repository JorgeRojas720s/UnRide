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

//!Registrar al user normal
class AuthenticationUserRegister extends AuthenticationEvent {
  final String identification;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String password;
  final String profilePictureUrl;
  final bool hasVehicle;
  final String licensePlate;
  final String make;
  final String model;
  final String year;
  final String color;
  final String vehicleType;

  AuthenticationUserRegister({
    required this.identification,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
    required this.profilePictureUrl,
    required this.hasVehicle,
    this.licensePlate = "",
    this.make = "",
    this.year = "",
    this.color = "",
    this.model = "",
    this.vehicleType = "",
  });

  @override
  List<Object> get props => [];
}

class AuthenticationUserSignIn extends AuthenticationEvent {
  final String email;

  final String password;

  AuthenticationUserSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
