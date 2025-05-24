import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:un_ride/repository/client_post/client_post_repository.dart';
import 'package:un_ride/repository/repository.dart';

part 'client_post_event.dart';
part 'client_post_state.dart';

class ClientPostBloc extends Bloc<ClientPostEvent, ClientPostState> {
  final ClientPostRepository _publicationRepository;

  ClientPostBloc({required ClientPostRepository publication_repository})
    : _publicationRepository = publication_repository,
      super(const ClientPostState.unknown()) {
    //!Aqi los envents
    on<ClientPostRegister>((event, emit) async {
      try {
        await _publicationRepository.savePost(
          user: event.user,
          origin: event.origin,
          destination: event.destination,
          description: event.description,
          passengers: event.passengers,
          suggestedAmount: event.suggestedAmount,
          postDate: event.postDate,
          travelDate: event.travelDate,
          travelTime: event.travelTime,
        );

        emit(const ClientPostState.published());
      } catch (e) {
        print(e);
        print("No se publico");
      }
    });
  }
}
