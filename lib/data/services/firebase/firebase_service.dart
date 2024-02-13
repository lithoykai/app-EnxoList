import 'dart:io';

abstract class FirebaseService {
  Future<String?> uploadImage(File? file, String imageName);
}
