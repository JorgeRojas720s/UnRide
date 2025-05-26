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

  //!El viejo
  // Stream<User> get user {
  //   return _firebaseAuth.authStateChanges().map((firebaseUser) {
  //     return firebaseUser == null ? User.empty : firebaseUser.toUserAuth;
  //   });
  // }

  // //!Probar luego, es para que al entrar a la app vaya detenctando si tiene vehicle
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return User.empty;
      }

      Map<String, dynamic> userData = await getUserDataFromFirestore(
        firebaseUser.uid,
      );

      return userData.toUser();
    });
  }

  //!Lo dio gepeto para quitar el cuando se quita de fireAuth
  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  //!Registro de user normal
  Future<User> signUp({
    required String identification,
    required String name,
    required String surname,
    required String phone,
    required String email,
    required String password,
    required String profilePictureUrl,
    required bool hasVehicle,
    required String licensePlate,
    required String make,
    required String year,
    required String color,
    required String model,
    required String vehicleType,
  }) async {
    try {
      firebase_auth.UserCredential result = await registerAuthUser(
        email,
        password,
      );

      final authUser = result.user;

      if (authUser == null) {
        throw Exception("Usuario no autenticado");
      }

      await registerUser(
        authUser,
        identification,
        name,
        surname,
        email,
        phone,
        profilePictureUrl,
        hasVehicle,
      );

      if (hasVehicle) {
        await registerVehicle(
          authUser,
          licensePlate,
          make,
          year,
          color,
          model,
          vehicleType,
        );
      }

      return authUser.toUserAuth;
    } on Exception {
      print("No sirvio el registro: ❌❌❌❌❌");
      throw SignUpFailure();
    }
  }

  Future<firebase_auth.UserCredential> registerAuthUser(
    String email,
    String password,
  ) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> registerVehicle(
    firebase_auth.User authUser,
    String licensePlate,
    String make,
    String year,
    String color,
    String model,
    String vehicleType,
  ) async {
    await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(authUser.uid)
        .set({
          'licensePlate': licensePlate,
          'make': make,
          'year': year,
          'color': color,
          'model': model,
          'vehicleType': vehicleType,
        });
  }

  Future<void> registerUser(
    firebase_auth.User firebaseUser,
    String identification,
    String name,
    String surname,
    String email,
    String phone,
    String profilePictureUrl,
    bool hasVehicle,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .set({
          'identification': identification,
          'name': name,
          'surname': surname,
          'email': email,
          'phoneNumber': phone,
          'profilePictureUrl': profilePictureUrl,
          'hasVehicle': hasVehicle,
        });
    print("📍📍📍📍 ");
  }

  //!Iniciar sesion con email y password
  Future<User> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final authUser = result.user;

      if (authUser == null) {
        throw Exception("Usuario no autenticado");
      }

      Map<String, dynamic> userData = await getUserDataFromFirestore(
        authUser.uid,
      );

      print('☁️☁️☁️☁️☁️☁️ $authUser.uid');

      return userData.toUser();

      // return userData.toUser(authUser.uid);
    } on Exception {
      throw LoginWithEmailAndPasswordFailure();
    }
  }

  Future<Map<String, dynamic>> getUserDataFromFirestore(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      return snapshot.data()!;
    } else {
      throw Exception("No se encontraron datos para el usuario.");
    }
  }

  //!Cerrar sesion
  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } on Exception {
      print("Fallo el logout");
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
  User get toUserAuth {
    return User(
      id: uid,
      name: displayName ?? '',
      surname: '',
      email: email ?? '',
      phoneNumber: phoneNumber ?? '',
      profilePictureUrl: photoURL ?? '',
      hasVehicle: false,
    );
  }
}

extension UserFromMap on Map<String, dynamic> {
  User toUser() {
    return User(
      id: this['identification'] ?? '',
      name: this['name'] ?? '',
      email: this['email'] ?? '',
      surname: this['surname'] ?? '',
      phoneNumber: this['phoneNumber'] ?? '',
      profilePictureUrl: this['profilePictureUrl'] ?? '',
      hasVehicle: this['hasVehicle'] ?? false,
    );
  }
}
