import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  String? _url;
  String? get url => _url;

  bool _veiw = true;
  bool get veiw => _veiw;

  void changeVeiw() {
    _veiw = !_veiw;
    update();
  }
}
