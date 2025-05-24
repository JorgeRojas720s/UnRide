part of 'publication_bloc.dart';

abstract class PublicationEvent extends Equatable {
  const PublicationEvent();

  @override
  List<Object?> get props => [];
}

class PublicationPost extends PublicationEvent {
  final User user;
  final String origin;
  final String destination;
  final String description;
  final DateTime travelDate;
  final DateTime publicationDate;
  final double suggestedAmount;

  PublicationPost({
    required this.user,
    required this.origin,
    required this.destination,
    required this.description,
    required this.travelDate,
    required this.publicationDate,
    required this.suggestedAmount,
  });

  @override
  List<Object?> get props => [
    user,
    origin,
    destination,
    description,
    travelDate,
    publicationDate,
    suggestedAmount,
  ];
}
