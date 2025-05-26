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

class AuthenticationUserSignIn extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationUserSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

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
  List<Object> get props => [
    identification,
    name,
    surname,
    email,
    phone,
    password,
    profilePictureUrl,
    hasVehicle,
    licensePlate,
    make,
    model,
    year,
    color,
    vehicleType,
  ];
}

class UpdateUser extends AuthenticationEvent {
  final String uid;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String profilePictureUrl;
  final bool hasVehicle;
  final String licensePlate;
  final String make;
  final String model;
  final String year;
  final String color;
  final String vehicleType;

  UpdateUser({
    required this.uid,
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
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
  List<Object> get props => [
    uid,
    name,
    surname,
    email,
    phone,
    profilePictureUrl,
    hasVehicle,
    licensePlate,
    make,
    model,
    year,
    color,
    vehicleType,
  ];
}
