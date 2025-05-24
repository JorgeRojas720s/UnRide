import 'package:cloud_firestore/cloud_firestore.dart';
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
    required DateTime? travelDate,
    required String? travelTime,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('posts').add({
        'userId': user.id,
        'origin': origin,
        'destination': destination,
        'description': description,
        'travelDate': travelDate,
        'postDate': postDate,
        'suggestedAmount': suggestedAmount,
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
    required DateTime? travelDate,
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
}
