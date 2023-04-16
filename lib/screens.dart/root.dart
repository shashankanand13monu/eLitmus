
import 'package:elitmus_project/main.dart';
import 'package:elitmus_project/screens.dart/homepage.dart';
import 'package:elitmus_project/screens.dart/level1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../utils/utils.dart';
import 'login/login_page.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  final userdate = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userdate.writeIfNull('isLogged', false);

    Future.delayed(Duration.zero,() async{
      checkiflogged();
    });

  }

  @override
  Widget build(BuildContext context) {
   final userdate = GetStorage();

    Utils().init(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:  CircularProgressIndicator()
        ),
      ),

    );
  }

  void checkiflogged() {
    userdate.read('isLogged') ? Get.offAll(HomePage()) : Get.offAll(LoginPage());
  }
}
