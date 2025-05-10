import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String email;
  // final String phoneNumber;
  // final String address;
  final String profilePictureUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    // required this.phoneNumber,
    // required this.address,
    required this.profilePictureUrl,
  }) : assert(id != null);

  static const empty = User(
    id: '',
    name: '',
    email: '',
    // phoneNumber: '',
    // address: '',
    profilePictureUrl: '',
  );

  // @override
  // List<Object?> get props => [id, name, email, phoneNumber, address, profilePictureUrl];

  @override
  List<Object?> get props => [id, name, email, profilePictureUrl];

  @override
  bool get stringify => true;
}
