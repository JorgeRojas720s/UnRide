import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:un_ride/repository/authentication/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//!Luego meto todos estos posibles fallos en un archivo de errores
class SignUpFailure implements Exception {}

class LoginWithEmailAndPasswordFailure implements Exception {}

class LogInWithGoogleFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn();

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  //!Registro a un usuario con email y password
  //! Quiza deberia de retornar el user
  Future<User> signUp({
    required String identification,
    required String name,
    required String surname,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("🫏🫏🫏 $result");
      final firebaseUser = result.user;

      if (firebaseUser == null) {
        throw Exception("Usuario no autenticado");
      }
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $user");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set({
            'identification': identification,
            'name': name,
            'surname': surname,
            'email': email,
            'phoneNumber': phone,
            'profilePictureUrl': firebaseUser.photoURL ?? '',
          });

      //!Revisar luego si no me chingue cone esto
      if (firebaseUser != null) {
        return firebaseUser.toUser;
      } else {
        throw Exception("Usuario no autenticado");
      }
    } on Exception {
      throw SignUpFailure();
    }
  }

  //!Iniciar sesion con email y password
  //! Quiza deberia de retornar el user
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LoginWithEmailAndPasswordFailure();
    }
  }

  //!Cerrar sesion
  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } on Exception {
      throw LogOutFailure();
    }
  }

  //!Login con google
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }
}

//! Esta extension convierte un objeto de tipo firebase_auth.User a un objeto de tipo User
extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      name: displayName ?? '',
      email: email ?? '',
      phoneNumber: phoneNumber ?? '',
      profilePictureUrl: photoURL ?? '',
    );
  }
}
