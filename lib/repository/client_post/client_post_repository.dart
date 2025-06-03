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
      print("Se guardo el post  ✅✅✅");
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
  Future<List<Post>> getUserPosts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('clientPosts').get();

      print("✅✅✅✅✅✅✅✅");
      print(snapshot.docs.map((doc) => doc.data()).toList());

      final posts = snapshot.docs.map((doc) => doc.data().toPost()).toList();

      return posts;
    } catch (e) {
      print(e);
      print("En repository no se pudo cargar los post ❌❌❌");
      return const [];
    }
  }
}

// {travelDate: Timestamp(seconds=1748476800, nanoseconds=0), suggestedAmount: 12000.0, origin: canada, destination: este, description: cacadsfdsgfgfdgfdhgfdhfghfgjhfgjfhgjfhjfhgjhfjhfj, postDate: Timestamp(seconds=1748137205, nanoseconds=725000000), userId: ehPR0mI1y4PbEdKWRdREKYsxuE13}, {suggestedAmount: 50000.0, travelDate: Timestamp(seconds=1748563200, nanoseconds=0), origin: popopo, destination: kjbb, description: lololo, postDate: Timestamp(seconds=1748126728, nanoseconds=251000000), userId: ehPR0mI1y4PbEdKWRdREKYsxuE13}]

//!Devolver el array de posts
extension PostFromMap on Map<String, dynamic> {
  Post toPost() {
    return Post(
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
