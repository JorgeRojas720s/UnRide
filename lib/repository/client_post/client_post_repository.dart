import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:un_ride/repository/repository.dart';

class ClientPostRepository {
  ClientPostRepository();

  Future<void> savePost({
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
      await FirebaseFirestore.instance.collection('posts').doc(user.id).set({
        'origin': origin,
        'destination': destination,
        'description': description,
        'travelDate': travelDate,
        'postDate': postDate,
        'suggestedAmount': suggestedAmount,
      });
    } catch (e) {
      print(e);
      print("Error, save publication");
    }
  }

  Future<void> editPublication() async {}
  Future<void> deletePublication() async {}
}
