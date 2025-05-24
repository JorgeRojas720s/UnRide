part of 'client_post_bloc.dart';

abstract class ClientPostEvent extends Equatable {
  const ClientPostEvent();

  @override
  List<Object?> get props => [];
}

class ClientPostRegister extends ClientPostEvent {
  final User user;
  final String origin;
  final String destination;
  final String description;
  final int passengers;
  final double suggestedAmount;
  final DateTime postDate;
  final DateTime? travelDate;
  final String? travelTime;

  ClientPostRegister({
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

class updateClientPost extends ClientPostEvent {
  final User user;
  final String origin;
  final String destination;
  final String description;
  final int passengers;
  final double suggestedAmount;
  // final DateTime postDate;
  final DateTime? travelDate;
  final String? travelTime;

  updateClientPost({
    required this.user,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount,
    required this.travelDate,
    required this.travelTime,
  });

  @override
  List<Object?> get props => [
    user,
    origin,
    destination,
    description,
    passengers,
    suggestedAmount,
    travelDate,
    travelTime,
  ];
}

class deleteClientPost extends ClientPostEvent {
  //!Ocupo saber como obtengo el id del post
}

//!Estados de los posts

class LoadClientPosts extends ClientPostEvent {
  LoadClientPosts();

  @override
  List<Object?> get props => [];
}
