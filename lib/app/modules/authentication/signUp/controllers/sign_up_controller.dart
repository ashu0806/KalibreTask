import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kalibre_task/app/data/components/app_constant.dart';
import 'package:kalibre_task/app/data/services/config.dart';
import 'package:kalibre_task/app/data/services/models/user_model.dart';

class SignUpController extends GetxController {
  final _isPasswordHidden = true.obs;
  final _isConPasswordHidden = true.obs;
  final _isChecked = false.obs;

  var loadingStatus = LoadingStatus.loading.obs;

  bool get isPasswordHidden => _isPasswordHidden.value;
  bool get isConPasswordHidden => _isConPasswordHidden.value;
  bool get isChecked => _isChecked.value;

  void togglePasswordView() {
    _isPasswordHidden.value = !_isPasswordHidden.value;
  }

  void toggleConPasswordView() {
    _isConPasswordHidden.value = !_isConPasswordHidden.value;
  }

  void toggleTermsAndConditions() {
    _isChecked.value = !_isChecked.value;
  }

  void signUp({
    required String emailAddress,
    required String password,
    required String userName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_user_data', '');
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final user = UserModel(
        uId: firebaseAuth.currentUser!.uid,
        name: userName,
        email: emailAddress,
      );
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .set(
            user.toMap(),
          );

      Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.back();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Email alreay in use.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "invalid-email") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Invalid email.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "operation-not-allowed") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Operation not allowed.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "weak-password") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Password is very weak.",
          position: SnackPosition.BOTTOM,
        );
      }
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
