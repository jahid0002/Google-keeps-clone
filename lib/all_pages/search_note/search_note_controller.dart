import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchNoteController extends GetxController {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? _data;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get data => _data;

  void getData(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) {
    _data = value;
    update();
  }
}
