import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DocumentService {
  final String uId;
  DocumentService({this.uId});

  final FirebaseStorage _documentRef =
      FirebaseStorage(storageBucket: "gs://jobportal-e73b7.appspot.com/");

  Future savePdf(List<int> asset, String name) async {
    try {
      String _path = 'AllCvs/$uId/$name';
      var storageRef = _documentRef.ref().child(_path);
      StorageUploadTask uploadTask = storageRef.putData(asset);
      String url = await (await uploadTask.onComplete).ref.getDownloadURL();
      return url;
    } on Exception catch (e) {
      throw e;
    }
  }
}
