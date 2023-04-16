import 'package:elitmus_project/controllers/auth_controller.dart';
import 'package:elitmus_project/controllers/user_data.dart';
import 'package:elitmus_project/models/usermodel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _userRepo = Get.put(UserRepository());
    final userdate = GetStorage();


  getUserData() {
    final email = userdate.read('email');
    // final email = "hii@hii.com";

    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.allUser();
  }

  updateScore(UserModel user) async{
    await _userRepo.updateUser(user);
  }
}
