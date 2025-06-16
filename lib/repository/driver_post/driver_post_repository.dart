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
    required bool allowsPets,
    required bool allowsLuggage,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('driverPosts').add({
        'userId': user.id,
        'name': user.name,
        'surname': user.surname,
        'profilePictureUrl': user.profilePictureUrl,
        'phoneNumber': user.phoneNumber,

        'origin': origin,
        'destination': destination,
        'description': description,
        'passengers': passengers,
        'suggestedAmount': suggestedAmount,
        'postDate': postDate,
        'travelDate': travelDate,
        'travelTime': travelTime,
        'allowsPets': allowsPets,
        'allowsLuggage': allowsLuggage,
      });
    } catch (e) {
      print(e);
      print("En repository no se registro el post del driver ❌❌❌");
    }
  }

  Future<void> updateDriverPost({
    required User user,
    required String postId,
    required String origin,
    required String destination,
    String? description,
    required int passengers,
    required double suggestedAmount,
    required String? travelDate,
    required String? travelTime,
    required bool allowsPets,
    required bool allowsLuggage,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('driverPosts')
          .doc(postId)
          .update({
            'userId': user.id,
            'origin': origin,
            'destination': destination,
            'description': description ?? '',
            'passengers': passengers,
            'suggestedAmount': suggestedAmount,
            'travelDate': travelDate ?? '',
            'travelTime': travelTime ?? '',
            'allowsPets': allowsPets,
            'allowsLuggage': allowsLuggage,
          });

      print("Se actualizó el post  ✅✅✅");
    } catch (e) {
      print(e);
      print("En repository no se actualizó el post de driver ❌❌❌");
    }
  }

  Future<void> deleteDriverPost({required String? postId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('driverPosts')
          .doc(postId)
          .delete();
      print("✅ Post eliminado correctamente");
    } catch (e) {
      print(e);
      print("En repository no se pudo eliminar el post del driver ❌❌❌");
    }
  }

  //!De los posts
  Future<List<DriverPost>> getAllDriversPosts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('driverPosts').get();

      print("👾👾👾👾👾👾👾👾👾👾👾👾👾👾👾");
      print(snapshot.docs.map((doc) => doc.data()));

      final posts =
          snapshot.docs.map((doc) => doc.data().toDriverPost()).toList();

      print("✅✅✅✅✅✅✅✅");
      print(posts);
      return posts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post de los drivers ❌❌❌");
      return const [];
    }
  }

  Future<List<DriverPost>> getDriverPost({required User user}) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('driverPosts')
              .where('userId', isEqualTo: user.id)
              .get();

      final userPosts =
          snapshot.docs.map((doc) {
            final post = doc.data().toDriverPost();
            post.postId = doc.id;
            return post;
          }).toList();

      print("✅✅✅✅✅✅✅✅saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(userPosts);

      return userPosts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post del driver user ❌❌❌");
      return const [];
    }
  }
}

//!Devolver el array de posts
extension PostFromMap on Map<String, dynamic> {
  DriverPost toDriverPost() {
    return DriverPost(
      userId: this['userId'] ?? null,
      postId: this['postId'] ?? null,
      name: this['name'] ?? null,
      surname: this['surname'] ?? null,
      phoneNumber: this['phoneNumber'] ?? null,
      profilePictureUrl: this['profilePictureUrl'] ?? null,

      origin: this['origin'] ?? null,
      destination: this['destination'] ?? null,
      description: this['description'] ?? null,
      passengers: this['passengers'] ?? 0,
      postDate: this['postDate'] != null ? this['postDate'].toDate() : null,
      suggestedAmount:
          (this['suggestedAmount'] is int)
              ? (this['suggestedAmount'] as int).toDouble()
              : (this['suggestedAmount'] ?? 0.0),
      travelDate: this['travelDate'] ?? null,
      travelTime: this['travelTime'] ?? null,
      allowsPets: this['allowsPets'] ?? false,
      allowsLuggage: this['allowsLuggage'] ?? false,
    );
  }
}
