import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/usermodel.dart';
import '../utils/utils.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
    final userdate = GetStorage();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    await _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: kPrimaryColor,
            colorText: kBackgroundColor))
        .catchError((e) => Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: kPrimaryColor,
            colorText: kBackgroundColor));
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('Users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    //order by string score to int score
   
    final snapshot =
        await _db.collection('Users').orderBy('score', descending: true).get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUser(UserModel user) async {
    print("--");

    await _db.collection('Users').doc(userdate.read('id')).update(user.toJson()).catchError(
        (e) => Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: kPrimaryColor,
            colorText: kBackgroundColor));
  }
}
