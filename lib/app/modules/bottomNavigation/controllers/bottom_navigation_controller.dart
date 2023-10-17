import 'package:get/get.dart';
import 'package:kalibre_task/app/modules/home/controllers/home_controller.dart';
import 'package:kalibre_task/app/modules/profile/controllers/profile_controller.dart';

class BottomNavigationController extends GetxController {
  final _currrentIndex = 0.obs;

  int get currentIndex => _currrentIndex.value;

  @override
  void onInit() {
    Get.put(
      HomeController(),
    );
    Get.put(
      ProfileController(),
    );
    super.onInit();
  }

  void setIndex(int index) {
    _currrentIndex.value = index;
  }

  void setIndexZero() {
    _currrentIndex.value = 0;
  }
}
