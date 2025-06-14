import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:un_ride/repository/client_post/models/client_post.dart';
import 'package:un_ride/repository/driver_post/models/driver_post.dart';
import 'package:un_ride/repository/repository.dart';

class DriverPostRepository {
  DriverPostRepository();

  Future<void> createDriverPost({
    required User user,
    required String origin,
    required String destination,
    String? description,
    required passengers,
    required double suggestedAmount,
    required DateTime postDate,
    required String? travelDate,
    required String? travelTime,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('driverPosts').add({
        'userId': user.id,
        'origin': origin,
        'destination': destination,
        'description': description,
        'passengers': passengers,
        'suggestedAmount': suggestedAmount,
        'postDate': postDate,
        'travelDate': travelDate,
        'travelTime': travelTime,
      });
    } catch (e) {
      print(e);
      print("En repository no se registro el post del cliente ❌❌❌");
    }
  }

  Future<void> updateDriverPost({
    required User user,
    required String origin,
    required String destination,
    String? description,
    required passengers,
    required double suggestedAmount,
    required String? travelDate,
    required String? travelTime,
  }) async {
    try {
      //!Ocupo recibir el uid del post

      print("Se actualizó el post  ✅✅✅");
    } catch (e) {
      print(e);
      print("En repository no se actualizo el post de cliente ❌❌❌");
    }
  }

  Future<void> deleteDriverPost() async {}

  //!De los posts
  Future<List<DriverPost>> getAllDriversPosts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('driverPosts').get();

      print("✅✅✅✅✅✅✅✅");
      print(snapshot.docs.map((doc) => doc.data()).toList());

      final posts =
          snapshot.docs.map((doc) => doc.data().toDriverPost()).toList();

      return posts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post ❌❌❌");
      return const [];
    }
  }

  Future<List<DriverPost>> getDriverPost({required User user}) async {
    try {
      print('koka: $user');
      print('pepepe:');
      print(user.id);

      final snapshot =
          await FirebaseFirestore.instance
              .collection('driverPosts')
              .where('userId', isEqualTo: user.id)
              .get();

      print("✅✅✅✅✅✅✅✅");
      print(snapshot.docs.map((doc) => doc.data()).toList());

      final UserPosts =
          snapshot.docs.map((doc) => doc.data().toDriverPost()).toList();

      return UserPosts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post del client user ❌❌❌");
      return const [];
    }
  }
}

//!Devolver el array de posts
extension PostFromMap on Map<String, dynamic> {
  DriverPost toDriverPost() {
    return DriverPost(
      userId: this['userId'] ?? null,
      origin: this['origin'] ?? null,
      destination: this['destination'] ?? null,
      description: this['description'] ?? null,
      passengers: this['passengers'] ?? 0,
      postDate: this['postDate'] != null ? this['postDate'].toDate() : null,
      suggestedAmount: this['suggestedAmount'] ?? null,
      travelDate: this['travelDate'] ?? null,
      travelTime: this['travelTime'] ?? null,
    );
  }
}
