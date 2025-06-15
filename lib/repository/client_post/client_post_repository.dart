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
      });
    } catch (e) {
      print(e);
      print("En repository no se registro el post del cliente ❌❌❌");
    }
  }

  Future<void> updateClientPost({
    required User user,
    required String postId,
    required String origin,
    required String destination,
    String? description,
    required passengers,
    required double suggestedAmount,
    required String? travelDate,
    required String? travelTime,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('clientPosts')
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
          });

      print("Se actualizó el post  ✅✅✅");
    } catch (e) {
      print(e);
      print("En repository no se actualizo el post de cliente ❌❌❌");
    }
  }

  Future<void> deleteClientPost({required String? postId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('clientPosts')
          .doc(postId)
          .delete();
      print("✅ Post eliminado correctamente");
    } catch (e) {
      print(e);
      print("En repository no se pudo eliminar el post del client ❌❌❌");
    }
  }

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

      final userPosts =
          snapshot.docs.map((doc) {
            final post = doc.data().toClientPost();
            post.postId = doc.id;
            return post;
          }).toList();

      return userPosts;
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
      suggestedAmount: this['suggestedAmount'] ?? null,
      travelDate: this['travelDate'] ?? null,
      travelTime: this['travelTime'] ?? null,
    );
  }
}
