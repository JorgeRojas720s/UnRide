import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:un_ride/repository/authentication/models/user.dart';

class Post extends Equatable {
  final String userId;
  final String origin;
  final String destination;
  final String? description;
  final int passengers;
  final double suggestedAmount;
  final DateTime? postDate;
  final DateTime? travelDate;
  final String? travelTime;

  const Post({
    required this.userId,
    required this.origin,
    required this.destination,
    this.description,
    required this.passengers,
    required this.suggestedAmount,
    required this.postDate,
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
}
