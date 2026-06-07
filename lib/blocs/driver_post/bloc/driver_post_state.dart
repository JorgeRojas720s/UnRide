part of 'driver_post_bloc.dart';

enum DriverPostStatus {
  unknown,
  published,
  deleted,
  updated,
  success,
  loading,
  error,
}

class DriverPostState extends Equatable {
  final DriverPostStatus status;
  final List<DriverPost> posts;

  const DriverPostState({
    this.status = DriverPostStatus.unknown,
    this.posts = const [],
  });

  const DriverPostState.unknown() : this();

  const DriverPostState.published() : this(status: DriverPostStatus.published);

  const DriverPostState.deleted() : this(status: DriverPostStatus.deleted);

  const DriverPostState.updated() : this(status: DriverPostStatus.updated);

  //!Estados de la publicacion

  const DriverPostState.success(List<DriverPost> posts)
    : this(status: DriverPostStatus.success, posts: posts);

  const DriverPostState.loading() : this(status: DriverPostStatus.loading);

  const DriverPostState.error() : this(status: DriverPostStatus.error);

  @override
  List<Object?> get props => [status, posts];
}
