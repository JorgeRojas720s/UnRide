import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:un_ride/repository/authentication/models/user.dart';

class Post extends Equatable {
  final int? id;
  final String userId;
  final String origin;
  final String destination;
  final String? description;
  final int passengers;
  final double suggestedAmount;
  final DateTime? postDate;
  final String? travelDate;
  final String? travelTime;

  const Post({
    this.id,
    required this.userId,
    required this.origin,
    required this.destination,
    this.description,
    required this.passengers,
    required this.suggestedAmount,
    this.postDate,
    this.travelDate,
    this.travelTime,
  });

  static const empty = Post(
    userId: '',
    origin: '',
    destination: '',
    description: '',
    passengers: 0,
    suggestedAmount: 0,
    postDate: null,
    travelDate: null,
    travelTime: '',
  );

  @override
  List<Object?> get props => [
    userId,
    origin,
    destination,
    description,
    passengers,
    suggestedAmount,
    postDate,
    travelDate,
    travelTime,
  ];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'userId': userId,
      'origin': origin,
      'destination': destination,
      'description': description,
      'passengers': passengers,
      'suggestedAmount': suggestedAmount,
      'travelDate': travelDate,
      'travelTime': travelTime,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as int?,
      userId: map['userId'] as String,
      origin: map['origin'] as String,
      destination: map['destination'] as String,
      description: map['description'] as String,
      passengers: map['passengers'] as int,
      suggestedAmount: map['suggestedAmount'] as double,
      travelDate: map['travelDate'] as String,
      travelTime: map['travelTime'] as String,
    );
  }
}
