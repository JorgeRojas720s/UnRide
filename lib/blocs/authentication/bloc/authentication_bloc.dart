import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:un_ride/repository/repository.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<User> _userSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
       super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );

    on<AuthenticationUserChanged>((event, emit) async {
      // await Future.delayed(
      //   const Duration(seconds: 5),
      // ); //! Simula un retaro pa ver el spalsh
      emit(_mapAuthenticationUserChangedToState(event));

      //!Esto me lo dio gepeto para eliminar el user de fireAuth//////////////
      try {
        final currentUser = _authenticationRepository.currentUser;

        await currentUser?.reload(); // Fuerza la recarga desde Firebase

        final refreshedUser = _authenticationRepository.currentUser;

        if (refreshedUser == null) {
          // El usuario fue eliminado de FirebaseAuth
          emit(const AuthenticationState.unauthenticated());
        } else {
          await Future.delayed(const Duration(seconds: 5)); // Simula splash
          emit(_mapAuthenticationUserChangedToState(event));
        }
      } catch (_) {
        emit(const AuthenticationState.unauthenticated());
      }
      //!Hasta aqui/////////////////////////////////////////////////////
    });

    on<AuthenticationUserSignIn>((event, emit) async {
      final user = await _authenticationRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      print("✅✅✅✅✅✅✅✅✅✅");
      print(user);

      if (user.hasVehicle) {
        emit(AuthenticationState.authenticatedWithVehicle(user));
      } else if (!user.hasVehicle) {
        emit(AuthenticationState.unauthenticated());
      } else {
        emit(AuthenticationState.unauthenticated());
      }
    });

    //! Aqui se maneja el evento de logout
    on<AuthenticationLogoutRequested>((event, emit) async {
      await _authenticationRepository.logOut();
      emit(const AuthenticationState.unauthenticated());
    });

    //!Manejar la autentication del usuario que se registre
    on<AuthenticationUserRegister>((event, emit) async {
      try {
        final user = await _authenticationRepository.signUp(
          identification: event.identification,
          name: event.name,
          surname: event.surname,
          phone: event.phone,
          email: event.email,
          password: event.password,
          profilePictureUrl: event.profilePictureUrl,
          hasVehicle: event.hasVehicle,
          licensePlate: event.licensePlate,
          make: event.make,
          year: event.year,
          color: event.color,
          model: event.model,
          vehicleType: event.vehicleType,
        );

        if (event.hasVehicle) {
          emit(AuthenticationState.authenticatedWithVehicle(user));
        } else {
          emit(AuthenticationState.authenticated(user));
        }
      } catch (e) {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  } //?Fin del constructor

  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
    print(event.user);
    print("💐💐💐💐💐");

    return event.user != User.empty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
