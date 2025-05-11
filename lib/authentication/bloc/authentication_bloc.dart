import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:un_ride/repository/repository.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<User> _userSubscription;

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(AuthenticationUserChanged(user)),
    );
    // Usa `on<EventType>` para manejar los eventos
    on<AuthenticationUserChanged>((event, emit) {
      emit(_mapAuthenticationUserChangedToState(event));
    });
    on<AuthenticationLogoutRequested>((event, emit) async {
      await _authenticationRepository.logOut();
      emit(const AuthenticationState.unauthenticated());
    });
  }

  // Aquí es donde mapeas el evento a un nuevo estado
  AuthenticationState _mapAuthenticationUserChangedToState(
    AuthenticationUserChanged event,
  ) {
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



// import 'dart:math';

// import 'package:equatable/equatable.dart';
// import 'package:un_ride/repository/repository.dart';
// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'authentication_state.dart';
// part 'authentication_event.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final AuthenticationRepository _authenticationRepository;
//   late StreamSubscription<User> _userSubscription;

//   AuthenticationBloc({
//     required AuthenticationRepository authenticationRepository,
//   }) : assert(authenticationRepository != null),
//        _authenticationRepository = authenticationRepository,
//        super(const AuthenticationState.unknown()) {
//     _userSubscription = _authenticationRepository.user.listen(
//       (user) => add(AuthenticationUserChanged(user)),
//     );
//   }

  
//   Stream<AuthenticationState> mapEventToState(
//     AuthenticationEvent event,
//   ) async* {
//     if (event is AuthenticationUserChanged) {
//       yield _mapAuthenticationUserChangedToState(event);
//     } else if (event is AuthenticationLogoutRequested) {
//       unawaited(_authenticationRepository.logOut());
//     }
//   }

//   AuthenticationState _mapAuthenticationUserChangedToState(
//     AuthenticationUserChanged event,
//   ) {
//     return event.user != User.empty
//         ? AuthenticationState.authenticated(event.user)
//         : const AuthenticationState.unauthenticated();
//   }

//   @override
//   Future<void> close() {
//     _userSubscription.cancel();
//     return super.close();
//   }
// }
