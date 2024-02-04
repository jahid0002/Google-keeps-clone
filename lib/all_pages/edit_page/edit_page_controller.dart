import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPageController extends GetxController {
  // update image

  File? _image;
  File? get image => _image;

  void getImage(ImageSource source) async {
    final pickImage = await ImagePicker().pickImage(source: source);
    if (pickImage != null) {
      _image = File(pickImage.path);
      update();
    }
  }

  /// update firebase

  final email = FirebaseAuth.instance.currentUser!.email;
  final store = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance
      .ref('/image' + DateTime.now().microsecondsSinceEpoch.toString());
  void updateNote({
    required String title,
    required String note,
    required String time,
  }) async {
    if (_image == null) {
      await store.collection(email!).doc(time).update({
        'title': title,
        'note': note,
      }).then((value) {
        Get.snackbar("Done!", "Update succsesfully");
      }).onError((error, stackTrace) {
        Get.snackbar("Error", "Note not updated");
      });
    } else {
      var upload = await storage.putFile(_image!.absolute);
      await Future.value(upload).then((value) async {
        final newUrl = await storage.getDownloadURL();
        await store.collection(email!).doc(time).update(
            {'title': title, 'note': note, 'image': newUrl}).then((value) {
          Get.snackbar("Done!", "Update succsesfully");
        }).onError((error, stackTrace) {
          Get.snackbar("Error", "Note not updated");
        });
      });
    }
  }

  /// delete method
  void deleteNote(String time) async {
    await store.collection(email!).doc(time).delete().then((value) {
      Get.snackbar('Delete!', 'Successfully delete');
    }).onError((error, stackTrace) {
      Get.snackbar('Error', "Can't delete note");
    });
  }
}
