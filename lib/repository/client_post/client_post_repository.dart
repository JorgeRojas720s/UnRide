import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:un_ride/repository/client_post/models/client_post.dart';
import 'package:un_ride/repository/repository.dart';

class ClientPostRepository {
  ClientPostRepository();

  Future<void> createClientPost({
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
      await FirebaseFirestore.instance.collection('clientPosts').add({
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

  Future<void> updateClientPost({
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

  Future<void> deleteClientPost() async {}

  //!De los posts
  Future<List<ClientPost>> getAllClientsPosts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('clientPosts').get();

      print("✅✅✅✅✅✅✅✅");
      print(snapshot.docs.map((doc) => doc.data()).toList());

      final posts =
          snapshot.docs.map((doc) => doc.data().toClientPost()).toList();

      return posts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post de clients❌❌❌");
      return const [];
    }
  }

  Future<List<ClientPost>> getClientPosts({required User user}) async {
    try {
      print('koka: $user');
      print('pepepe:');
      print(user.id);

      final snapshot =
          await FirebaseFirestore.instance
              .collection('clientPosts')
              .where('userId', isEqualTo: user.id)
              .get();

      print("✅✅✅✅✅✅✅✅");
      print(snapshot.docs.map((doc) => doc.data()).toList());

      final UserPosts =
          snapshot.docs.map((doc) => doc.data().toClientPost()).toList();

      return UserPosts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post del client user ❌❌❌");
      return const [];
    }
  }
}

//!Devolver el array de posts
extension ClientPostFromMap on Map<String, dynamic> {
  ClientPost toClientPost() {
    return ClientPost(
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
