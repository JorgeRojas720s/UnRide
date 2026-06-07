import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:un_ride/repository/authentication/models/user.dart';

class DriverPost extends Equatable {
  final int? id;
  final String userId;
  String? postId;
  final String name;
  final String surname;
  final String phoneNumber;
  final String profilePictureUrl;

  final String origin;
  final String destination;
  final String? description;
  final int passengers;
  final double suggestedAmount;
  final DateTime? postDate;
  final String? travelDate;
  final String? travelTime;
  final bool allowsPets;
  final bool allowsLuggage;

  DriverPost({
    this.id,
    required this.userId,
    required this.postId,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.profilePictureUrl,

    required this.origin,
    required this.destination,
    this.description,
    required this.passengers,
    required this.suggestedAmount,
    this.postDate,
    this.travelDate,
    this.travelTime,
    required this.allowsPets,
    required this.allowsLuggage,
  });

  static final empty = DriverPost(
    userId: '',
    postId: '',
    name: '',
    surname: '',
    phoneNumber: '',
    profilePictureUrl: '',

    origin: '',
    destination: '',
    description: '',
    passengers: 0,
    suggestedAmount: 0,
    postDate: null,
    travelDate: null,
    travelTime: '',
    allowsPets: false,
    allowsLuggage: false,
  );

  @override
  List<Object?> get props => [
    userId,
    postId,
    name,
    surname,
    phoneNumber,
    profilePictureUrl,
    origin,
    destination,
    description,
    passengers,
    suggestedAmount,
    postDate,
    travelDate,
    travelTime,
    allowsPets,
    allowsLuggage,
  ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'userId': userId,
      'postId': postId,
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,

      'origin': origin,
      'destination': destination,
      'description': description,
      'passengers': passengers,
      'suggestedAmount': suggestedAmount,
      'travelDate': travelDate,
      'travelTime': travelTime,
      'allowsPets': allowsPets,
      'allowsLuggage': allowsLuggage,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory DriverPost.fromMap(Map<String, dynamic> map) {
    return DriverPost(
      id: map['id'] as int?,
      userId: map['userId'] as String,
      postId: map['postId'],
      name: map['name'] as String,
      surname: map['surname'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,

      origin: map['origin'] as String,
      destination: map['destination'] as String,
      description: map['description'] as String,
      passengers: map['passengers'] as int,
      suggestedAmount: map['suggestedAmount'] as double,
      travelDate: map['travelDate'] as String,
      travelTime: map['travelTime'] as String,
      allowsPets: map['allowsPets'] as bool,
      allowsLuggage: map['allowsLuggage'] as bool,
    );
  }
}
