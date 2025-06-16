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
  final String? travelDate;
  final String? travelTime;
  final bool allowsPets;
  final bool allowsLuggage;

  ClientPostRegister({
    required this.user,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount,
    required this.travelDate,
    required this.travelTime,
    required this.allowsPets,
    required this.allowsLuggage,
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
    allowsPets,
    allowsLuggage,
  ];
}

class UpdateClientPost extends ClientPostEvent {
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
  final bool allowsPets;
  final bool allowsLuggage;

  UpdateClientPost({
    required this.user,
    required this.postId,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount, //!Quitar el required
    required this.travelDate,
    required this.travelTime,
    required this.allowsPets,
    required this.allowsLuggage,
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
    allowsPets,
    allowsLuggage,
  ];
}

class DeleteClientPost extends ClientPostEvent {
  final String? postId;
  DeleteClientPost({required this.postId});
  @override
  List<Object?> get props => [postId];
}

//!Estados de los posts

class LoadClientsPosts extends ClientPostEvent {
  LoadClientsPosts();

  @override
  List<Object?> get props => [];
}

class LoadUserClientPosts extends ClientPostEvent {
  final User user;

  LoadUserClientPosts({required this.user});

  @override
  List<Object?> get props => [user];
}
