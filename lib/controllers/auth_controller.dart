import 'package:elitmus_project/controllers/user_data.dart';
import 'package:elitmus_project/models/usermodel.dart';
import 'package:elitmus_project/screens.dart/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../screens.dart/root.dart';
import '../utils/utils.dart';

class AuthController extends GetxController {
  var displayName = '';
  var displayEmail = '';
  final userdate = GetStorage();
  final userRepo = Get.put(UserRepository());

  FirebaseAuth auth = FirebaseAuth.instance;

  var isSignedIn = false.obs;

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName = userProfile != null ? userProfile!.displayName! : '';

    super.onInit();
  }

  void signUp(String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = name;
        displayEmail = email;
        auth.currentUser!.updateDisplayName(name);
        
      });

      update();
      final user = UserModel(
        
        name: displayName,
        email: email,
        score: 10000,
      );
      createUser(user);
      Get.offAll(() => Root());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName = userProfile!.displayName!);

      update();
      userdate.write('isLogged', true);
      userdate.write('email', email);
      userdate.write('name', displayName);

      Get.offAll(() => HomePage());
      print('Signed in successfully');
      userdate.write('id', userProfile!.uid);

      print(userdate.read('id'));
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kPrimaryColor,
        colorText: kBackgroundColor,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }

  void signout() async {
    try {
      await auth.signOut();
      displayName = '';
      isSignedIn.value = false;
      update();
      userdate.write('isLogged', false);
      userdate.remove('email');
      userdate.remove('name');
      userdate.remove('score');

      Get.offAll(() => Root());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kPrimaryColor,
          colorText: kBackgroundColor);
    }
  }
}

// // to capitalize first letter of a Sting
extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
