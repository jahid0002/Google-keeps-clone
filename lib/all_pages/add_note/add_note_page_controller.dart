import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddNotePageController extends GetxController {
// image picker

  File? _image;
  File? get image => _image;

  void getImage(ImageSource source) async {
    final pickImage = await ImagePicker().pickImage(source: source);
    if (pickImage != null) {
      _image = File(pickImage.path);
      update();
    }
  }

  /// add firebase
  final email = FirebaseAuth.instance.currentUser!.email.toString();
  final store = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance
      .ref('/image' + DateTime.now().microsecondsSinceEpoch.toString());
  final time = DateTime.now().microsecondsSinceEpoch.toString();

  void sendNote(String title, String note) async {
    if (_image == null) {
      await store.collection(email).doc(time).set({
        'title': title,
        'note': note,
        'time': time,
        'image': null,
      }).then((value) {
        Get.snackbar('Done!', 'Save notes');
      }).onError((error, stackTrace) {
        Get.snackbar('Error!', 'Not Save notes');
        print(error.toString());
      });
    } else {
      var upload = await storage.putFile(_image!.absolute);
      await Future.value(upload).then((value) async {
        final newUrl = await storage.getDownloadURL();
        await store.collection(email).doc(time).set({
          'title': title,
          'note': note,
          'time': time,
          'image': newUrl,
        }).then((value) {
          Get.snackbar('Done!', 'Save notes');
        }).onError((error, stackTrace) {
          Get.snackbar('Error!', 'Not Save notes');
          print(error.toString());
        });
      });
    }
  }
}
