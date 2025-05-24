part of 'client_post_bloc.dart';

enum ClientPostStatus { unknown, published, deleted, edited }

class ClientPostState extends Equatable {
  final ClientPostStatus status;

  const ClientPostState({this.status = ClientPostStatus.unknown});

  const ClientPostState.unknown() : this();

  const ClientPostState.published() : this(status: ClientPostStatus.published);

  const ClientPostState.deleted() : this(status: ClientPostStatus.deleted);

  const ClientPostState.edited() : this(status: ClientPostStatus.edited);

  @override
  List<Object?> get props => [status];
}
