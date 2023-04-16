import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/hero_title.dart';
import 'login_widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // shows header title
          HeroTitle(
            title: 'Welcome!',
            subtitle: 'Enter email and password to login...',
          ),
          // shows textfields and buttons
          SignInForm(),
        ],
      ),
    );
  }
}
