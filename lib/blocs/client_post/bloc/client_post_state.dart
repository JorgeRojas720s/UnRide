part of 'client_post_bloc.dart';

enum ClientPostStatus {
  unknown,
  published,
  deleted,
  edited,
  success,
  loading,
  error,
}

class ClientPostState extends Equatable {
  final ClientPostStatus status;
  final List<Map<String, dynamic>> posts;

  const ClientPostState({
    this.status = ClientPostStatus.unknown,
    this.posts = const [],
  });

  const ClientPostState.unknown() : this();

  const ClientPostState.published() : this(status: ClientPostStatus.published);

  const ClientPostState.deleted() : this(status: ClientPostStatus.deleted);

  const ClientPostState.edited() : this(status: ClientPostStatus.edited);

  //!Estados de la publicacion

  const ClientPostState.success(List<Map<String, dynamic>> posts)
    : this(status: ClientPostStatus.success, posts: posts);

  const ClientPostState.loading() : this(status: ClientPostStatus.loading);

  const ClientPostState.error() : this(status: ClientPostStatus.error);

  @override
  List<Object?> get props => [status, posts];
}
