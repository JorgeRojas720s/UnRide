import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:un_ride/repository/client_post/client_post_repository.dart';
import 'package:un_ride/repository/client_post/models/client_post.dart';
import 'package:un_ride/repository/repository.dart';

part 'client_post_event.dart';
part 'client_post_state.dart';

class ClientPostBloc extends Bloc<ClientPostEvent, ClientPostState> {
  final ClientPostRepository _clientPostRepository;

  ClientPostBloc({required ClientPostRepository clientPostRepository})
    : _clientPostRepository = clientPostRepository,
      super(const ClientPostState.loading()) {
    //!Aqi los envents
    on<ClientPostRegister>((event, emit) async {
      print("🫏🫏🫏🫏");
      print(event.travelTime);
      try {
        await _clientPostRepository.createClientPost(
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
        print("Desde Bloc no se pudo registrar el post ❌❌❌");
        emit(const ClientPostState.error());
      }
    });

    on<updateClientPost>((event, emit) async {
      try {} catch (e) {
        print(e);
        print("Desde Bloc no se pudo editar el post ❌❌❌");
      }
    });

    //!De los posts
    on<LoadClientPosts>((event, emit) async {
      try {
        final List<Post> posts = await clientPostRepository.getUserPosts();

        print("📍📍📍📍");
        print(posts);

        emit(ClientPostState.success(posts));
      } catch (e) {
        print(e);
        print("Desde Bloc no se pudo cargar los posts ❌❌❌");
        emit(ClientPostState.error());
      }
    });
  }
}
