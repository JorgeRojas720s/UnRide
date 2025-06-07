import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:un_ride/repository/client_post/client_post_repository.dart';
import 'package:un_ride/repository/client_post/models/client_post.dart';
import 'package:un_ride/repository/repository.dart';
import 'package:un_ride/sqlite/data/history/CRUD/history_dao.dart';

part 'client_post_event.dart';
part 'client_post_state.dart';

class ClientPostBloc extends Bloc<ClientPostEvent, ClientPostState> {
  final ClientPostRepository _clientPostRepository;
  final HistoryDao _historyDao = HistoryDao();

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

        //!Lo de sqlite
        // Post post = Post(
        //   userId: event.user.uid,
        //   origin: event.origin,
        //   destination: event.destination,
        //   description: event.description,
        //   passengers: event.passengers,
        //   suggestedAmount: event.suggestedAmount,
        //   travelDate: event.travelDate,
        //   travelTime: event.travelTime,
        // );

        // await _historyDao.insert(post);
        emit(const ClientPostState.published());
      } catch (e) {
        print(e);
        print("Desde Bloc no se pudo registrar el post ❌❌❌");
        emit(const ClientPostState.error());
      }
    });

    on<updateClientPost>((event, emit) async {
      try {
        clientPostRepository.updateClientPost(
          user: event.user,
          origin: event.origin,
          destination: event.destination,
          passengers: event.passengers,
          suggestedAmount: event.suggestedAmount,
          travelDate: event.travelDate,
          travelTime: event.travelTime,
        );

        emit(ClientPostState.updated());
      } catch (e) {
        print(e);
        print("Desde Bloc no se pudo editar el post ❌❌❌");
        emit(ClientPostState.error());
      }
    });

    //!De los posts
    on<LoadClientsPosts>((event, emit) async {
      try {
        final List<Post> posts = await clientPostRepository.getClientsPosts();

        //!Lo de sqlite
        // final List<Post> posts = await _historyDao.findAll();

        print("📍📍📍📍");
        print(posts);

        emit(ClientPostState.success(posts));
      } catch (e) {
        print(e);
        print("Desde Bloc no se pudo cargar los posts ❌❌❌");
        emit(ClientPostState.error());
      }
    });

    on<LoadUserClientPosts>((event, emit) async {
      try {
        final List<Post> userPosts = await clientPostRepository
            .getUserClientPosts(user: event.user);

        emit(ClientPostState.success(userPosts));
      } catch (e) {
        print("Desde Bloc no se pudo cargar los posts del user ❌❌❌");
        emit(ClientPostState.error());
      }
    });
  }
}
