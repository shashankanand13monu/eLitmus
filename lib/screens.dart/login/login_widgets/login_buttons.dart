import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/utils.dart';
import '../../../widgets/rounded_elevated_button.dart';
import '../../../widgets/text_with_textbutton.dart';
import '../../sign_up/sign_up.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    final userdate = GetStorage();

    return Expanded(
      flex: 1,
      child: Column(
        children: [
          //forget password button
          /*Padding(
            padding:
                EdgeInsets.symmetric(vertical: Utils.screenHeight! * 0.005),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text('Forgot Password?'),
                onPressed: () => Get.to(() => ResetPassword()),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                ),
              ),
            ),
          ),*/

          //login button
          Container(
                width: 160,
                height: 50,
                child: FloatingActionButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  splashColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                String email = _emailController.text.trim();
                String password = _passwordController.text;

                _authController.signIn(email, password);
                userdate.write('isLogged', true);

              } else {
                print("Wrong");
              }
                  },
                  backgroundColor: Colors.blue,
                ),
              ),
          // RoundedElevatedButton(
          //   title: 'Sign in',
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       String email = _emailController.text.trim();
          //       String password = _passwordController.text;

          //       _authController.signIn(email, password);
          //       userdate.write('isLogged', true);

          //     } else {
          //       print("Wrong");
          //     }
          //   },
          //   padding: EdgeInsets.symmetric(
          //     horizontal: Utils.screenWidth! * 0.4,
          //     vertical: Utils.screenHeight! * 0.01,
          //   ),
          // ),
          SizedBox(height: Utils.screenHeight! * 0.01),
          SignInButton.mini(
            buttonType: ButtonType.google,
            onPressed: () => print("Google"),
          ),
          TextWithTextButton(
            text: 'Don\'t have an account?',
            textButtonText: 'Sign up',
            onPressed: () => Get.to(() => SignUp()),
          ),
        ],
      ),
    );
  }
}
