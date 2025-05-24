import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:un_ride/repository/publication/publication_repository.dart';
import 'package:un_ride/repository/repository.dart';

part 'publication_event.dart';
part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  final PublicationRepository _publicationRepository;

  PublicationBloc({required PublicationRepository publication_repository})
    : _publicationRepository = publication_repository,
      super(const PublicationState.unknown()) {
    //!Aqi los envents
    on<PublicationPost>((event, emit) async {
      try {
        await _publicationRepository.savePublication(
          user: event.user,
          origin: event.origin,
          destination: event.destination,
          description: event.description,
          travelDate: event.travelDate,
          publicationDate: event.publicationDate,
          suggestedAmount: event.suggestedAmount,
        );

        emit(const PublicationState.published());
      } catch (e) {
        print(e);
        print("No se publico");
      }
    });
  }
}
