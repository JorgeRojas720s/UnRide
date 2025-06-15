part of 'driver_post_bloc.dart';

abstract class DriverPostEvent extends Equatable {
  const DriverPostEvent();

  @override
  List<Object?> get props => [];
}

class DriverPostRegister extends DriverPostEvent {
  final User user;
  final String origin;
  final String destination;
  final String description;
  final int passengers;
  final double suggestedAmount;
  final DateTime postDate;
  final String? travelDate;
  final String? travelTime;

  DriverPostRegister({
    required this.user,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount,
    required this.travelDate,
    required this.travelTime,
  }) : postDate = DateTime.now();

  @override
  List<Object?> get props => [
    user,
    origin,
    destination,
    description,
    passengers,
    suggestedAmount,
    postDate,
    travelDate,
    travelTime,
  ];
}

class UpdateDriverPost extends DriverPostEvent {
  final User user;
  final String postId;
  final String origin;
  final String destination;
  final String description;
  final int passengers;
  final double suggestedAmount;
  // final DateTime postDate;
  final String? travelDate;
  final String? travelTime;

  UpdateDriverPost({
    required this.user,
    required this.postId,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount, //!Quitar el required
    required this.travelDate,
    required this.travelTime,
  });

  @override
  List<Object?> get props => [
    user,
    postId,
    origin,
    destination,
    description,
    passengers,
    suggestedAmount,
    travelDate,
    travelTime,
  ];
}

class deleteDriverPost extends DriverPostEvent {
  //!Ocupo saber como obtengo el id del post
}

//!Estados de los posts

class LoadDriversPosts extends DriverPostEvent {
  LoadDriversPosts();

  @override
  List<Object?> get props => [];
}

class LoadUserDriverPosts extends DriverPostEvent {
  final User user;

  LoadUserDriverPosts({required this.user});

  @override
  List<Object?> get props => [user];
}
