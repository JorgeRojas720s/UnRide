import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:un_ride/repository/repository.dart';

class PublicationRepository {
  PublicationRepository();

  Future<void> savePublication({
    required User user,
    required String origin,
    required String destination,
    String? description,
    required DateTime travelDate,
    required DateTime publicationDate,
    required double suggestedAmount,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('publications')
          .doc(user.id)
          .set({
            'origin': origin,
            'destination': destination,
            'description': description,
            'travelDate': travelDate,
            'publicationDate': publicationDate,
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
