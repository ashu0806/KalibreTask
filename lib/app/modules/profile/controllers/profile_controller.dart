import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kalibre_task/app/data/components/app_constant.dart';
import 'package:kalibre_task/app/data/services/config.dart';
import 'package:kalibre_task/app/data/services/models/user_model.dart';

class ProfileController extends GetxController {
  // final _connectionValue = false.obs;
  // bool get connectionValue => _connectionValue.value;

  final _user = Rx<UserModel>(
    UserModel(
      uId: '',
      name: '',
      email: '',
    ),
  );
  UserModel get user => _user.value;

  @override
  void onInit() async {
    // _connectionValue.value = await AppConstant.checkConnection();
    fetchUserDetails();
    super.onInit();
  }

  void fetchUserDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedUserData = prefs.getString('cached_user_data');

      if (cachedUserData != '') {
        // log(cachedUserData);
        Map<String, dynamic> data = jsonDecode(cachedUserData ?? '');
        _user.value = UserModel.fromJson(data);
      } else {
        var data = await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .get();

        if (data.exists) {
          var userData = data.data();
          _user.value = UserModel.fromJson(userData!);
          await prefs.setString(
            'cached_user_data',
            jsonEncode(_user.value.toJson()),
          );
        }
      }
      // log(_user.value.toMap().toString());
    } catch (e) {
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await firebaseAuth.signOut();
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('cached_user_data', '');
          Get.back();
        },
      );
    } catch (e) {
      Get.back();
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }
}
