import 'package:chat/abstract/abstract_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService extends AbstractService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  
  @override
  Future<void> boot() async {
    await db
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
