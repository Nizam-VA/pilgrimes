import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_demo/models/pilgrim.dart';

class DatabaseServices {
  final String? id;
  DatabaseServices({this.id});

  //collection reference
  final CollectionReference pilgrimCollections =
      FirebaseFirestore.instance.collection('pilgrims');

  //insert data
  Future insertPilgrims(String id, String place, String description,
      String district, bool popular) async {
    Map<String, dynamic> pilgrim = {
      'id': id,
      'place': place,
      'description': description,
      'district': district,
      'popular': popular,
    };
    return await pilgrimCollections.doc(id).set(pilgrim).whenComplete(() {
      print('$id is created');
    });
  }

  //update data
  Future updatePilgrim(String id, String place, String description,
      String district, bool popular) async {
    return await pilgrimCollections.doc(id).set({
      'id': id,
      'place': place,
      'description': description,
      'district': district,
      'popular': popular
    }).whenComplete(() {
      print('$id is updated');
    });
  }

  //delete data
  Future deletePilgrim(String id) async {
    return await pilgrimCollections.doc(id).delete().whenComplete(() {
      print('$id is deleted');
    });
  }

  //popular pilgrims

  // pilgrim list from snapshot
  List<Pilgrim> _pilgrimListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Pilgrim(
        id: doc['id'] ?? '',
        place: doc['place'] ?? '',
        description: doc['description'] ?? '',
        district: doc['district'] ?? '',
        popular: doc['popular'] ?? '',
      );
    }).toList();
  }

  //pilgrim data from snapshot
  Pilgrim _pilgrimDataFromSnapshot(DocumentSnapshot snapshot) {
    return Pilgrim(
      id: snapshot['id'],
      place: snapshot['place'],
      description: snapshot['description'],
      district: snapshot['district'],
      popular: snapshot['popular'],
    );
  }

  Stream<List<Pilgrim>> get pilgrims {
    return pilgrimCollections.snapshots().map((_pilgrimListFromSnapshot));
  }

  Stream<Pilgrim> get pilgrimData {
    return pilgrimCollections.doc(id).snapshots().map(_pilgrimDataFromSnapshot);
  }
}
