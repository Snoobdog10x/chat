import 'package:chat/abstract/abstract_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService extends AbstractService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> getDownloadUrl(String path) async {
    String url = await storage.ref(path).getDownloadURL();
    return url;
  }

  @override
  Future<void> boot() async {}

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
