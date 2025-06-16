import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/repository/repository.dart';

part 'driver_post_event.dart';
part 'driver_post_state.dart';

class DriverPostBloc extends Bloc<DriverPostEvent, DriverPostState> {
  final DriverPostRepository _driverPostRepository;

  DriverPostBloc({required DriverPostRepository driverPostRepository})
    : _driverPostRepository = driverPostRepository,
      super(const DriverPostState.loading()) {
    on<DriverPostRegister>((event, emit) async {
      try {
        emit(DriverPostState.loading());
        await _driverPostRepository.createDriverPost(
          user: event.user,
          origin: event.origin,
          destination: event.destination,
          description: event.description,
          passengers: event.passengers,
          suggestedAmount: event.suggestedAmount,
          postDate: event.postDate,
          travelDate: event.travelDate,
          travelTime: event.travelTime,
          allowsPets: event.allowsPets,
          allowsLuggage: event.allowsLuggage,
        );

        emit(const DriverPostState.published());
      } catch (e) {
        print(e);
        print("Desde Bloc drivers no se pudo registrar el post ❌❌❌");
        emit(const DriverPostState.error());
      }
    });

    on<UpdateDriverPost>((event, emit) async {
      try {
        emit(DriverPostState.loading());
        await _driverPostRepository.updateDriverPost(
          user: event.user,
          postId: event.postId,
          origin: event.origin,
          destination: event.destination,
          passengers: event.passengers,
          suggestedAmount: event.suggestedAmount,
          travelDate: event.travelDate,
          travelTime: event.travelTime,
          allowsPets: event.allowsPets,
          allowsLuggage: event.allowsLuggage,
        );

        emit(DriverPostState.updated());
      } catch (e) {
        print(e);
        print("Desde Bloc no se pudo editar el post ❌❌❌");
        emit(DriverPostState.error());
      }
    });

    //!De los posts
    on<LoadDriversPosts>((event, emit) async {
      try {
        emit(DriverPostState.loading());

        final List<DriverPost> posts =
            await _driverPostRepository.getAllDriversPosts();

        print("📍📍📍📍📍📍📍📍📍📍📍📍📍");
        print(posts);

        emit(DriverPostState.success(posts));
      } catch (e) {
        print(e);
        print("Desde Bloc drivers no se pudo cargar los posts ❌❌❌");
        emit(DriverPostState.error());
      }
    });

    on<LoadUserDriverPosts>((event, emit) async {
      try {
        emit(DriverPostState.loading());
        final List<DriverPost> userPosts = await _driverPostRepository
            .getDriverPost(user: event.user);
        print("🍫🍫🍫🍫🍫🍫🍫🍫🍫🍫🍫🍫🍫🍫");
        print("⚙️⚙️⚙️⚙️⚙️⚙️");

        print(userPosts);

        emit(DriverPostState.success(userPosts));
      } catch (e) {
        print("Desde Bloc no se pudo cargar los posts del user ❌❌❌");
        emit(DriverPostState.error());
      }
    });

    on<DeleteDriverPost>((event, emit) async {
      try {
        print("🍫🍫🍫👾👾");
        print(event.postId);

        emit(DriverPostState.loading());
        await _driverPostRepository.deleteDriverPost(postId: event.postId);

        emit(DriverPostState.deleted());
      } catch (e) {
        print("Desde Bloc no se pudo eliminar el post del user ❌❌❌");
        emit(DriverPostState.error());
      }
    });
  }
}
