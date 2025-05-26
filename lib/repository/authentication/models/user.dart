import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;
  final bool hasVehicle;

  const User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.hasVehicle,
  }) : assert(id != null);

  static const empty = User(
    id: '',
    name: '',
    surname: '',
    email: '',
    phoneNumber: '',
    profilePictureUrl: '',
    hasVehicle: false,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    surname,
    email,
    phoneNumber,
    profilePictureUrl,
    hasVehicle,
  ];

  @override
  bool get stringify => true;
}
