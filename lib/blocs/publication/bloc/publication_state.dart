part of 'publication_bloc.dart';

enum PublicationStatus { unknown, published, deleted, edited }

class PublicationState extends Equatable {
  final PublicationStatus status;

  const PublicationState({this.status = PublicationStatus.unknown});

  const PublicationState.unknown() : this();

  const PublicationState.published()
    : this(status: PublicationStatus.published);

  const PublicationState.deleted() : this(status: PublicationStatus.deleted);

  const PublicationState.edited() : this(status: PublicationStatus.edited);

  @override
  List<Object?> get props => [status];
}
