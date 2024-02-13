import 'dart:io';

import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/services/firebase/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseService)
class FirebaseServiceImpl implements FirebaseService {
  @override
  Future<String?> uploadImage(File? image, String imageName) async {
    UserResponse? user;
    if (Hive.isBoxOpen('userData')) {
      var box = Hive.box('userData');
      user = box.get('userData');
    }
    String idUser = user!.id;
    if (image?.path == '') {
      return null;
    } else {
      final storage = FirebaseStorage.instance;
      final imageRef = storage.ref().child(idUser).child(imageName);

      await imageRef
          .putFile(image ??
              File.fromUri(Uri.parse(
                  'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg')))
          .whenComplete(() => {});
      return await imageRef.getDownloadURL();
    }
  }
}
