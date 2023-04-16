import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elitmus_project/controllers/controllerBindings.dart';
import 'package:elitmus_project/models/usermodel.dart';
import 'package:elitmus_project/screens.dart/homepage.dart';
import 'package:elitmus_project/screens.dart/level1.dart';
import 'package:elitmus_project/screens.dart/level2.dart';
import 'package:elitmus_project/screens.dart/level3.dart';
import 'package:elitmus_project/screens.dart/level4.dart';
import 'package:elitmus_project/screens.dart/level5.dart';
import 'package:elitmus_project/screens.dart/login/login_page.dart';
import 'package:elitmus_project/screens.dart/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBezd6PZTmF1tD9-2YeKtdy86_Hyz-p-Aw", appId: "1:145711649029:web:22ab8cc8e43abceabf276c", messagingSenderId: "145711649029", projectId: "elitmus-80e9c")
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBindings(),
      // initialRoute: "/home",
      title: 'Welcome to eLitmus',
      getPages: [
    GetPage(name: '/root', page: () => Root()),
    GetPage(name: '/home', page: () => HomePage()),

    GetPage(name: '/level1', page: () => Level1(),transition: Transition.zoom),
    GetPage(name: '/level2', page: () => Level2(),transition: Transition.cupertino),
    GetPage(name: "/level3", page: () => Level3(),transition: Transition.cupertinoDialog),
    GetPage(name: "/level4", page: () => Level4(),transition: Transition.leftToRightWithFade),
    GetPage(name: "/level5", page: () => Level5(),transition: Transition.leftToRightWithFade),

  ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue),
      ),
      home:  Root()
    );
  }
  // void checkiflogged() {
  //   userdate.read('isLogged') ? Get.offAll(Root()) : Get.offAll(LoginPage());
  // }

  
}
