import 'package:elitmus_project/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_details.dart';

class Level3 extends StatefulWidget {
  @override
  _Level3State createState() => _Level3State();
}

class _Level3State extends State<Level3> {
  final userdate = GetStorage();
  final controller = Get.put(ProfileController());
  int score = 0;
  Offset position = Offset.zero;
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    score = int.parse(userdate.read('score'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 3 "N"'),
        actions: [
          FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  // print(userdate.read('email'));
                  userdate.write('score', userData.score.toString());

                  return Center(
                    child: Text(
                      'Score: ${score}',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else {
                  return Center(child: Text('No data found'));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            child: ElevatedButton(
              // make round and color to white

              child: Text('Logout',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () {
                //logout
                Get.find<AuthController>().signout();
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // A text with big bold letters above the image
              Positioned(
                top: 50,
                child: Text(
                  'Open The Safe with the right key',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: ElevatedButton(
                  child: Text(
                    "Hint",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () async {
                    //show bottom sheet
                    Get.bottomSheet(
                      Container(
                        height: 100,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'Sometimes,its good to check the back of the safe for codes or key',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    );

                    setState(() {
                      score = score - 1500;
                userdate.write('score', score.toString());
                    });
                    final userData = UserModel(
                      name: userdate.read('name'),
                      email: userdate.read('email'),
                      score: int.parse(userdate.read('score')),
                    );
                    await controller.updateScore(userData);
                  },
                ),
              ),
              Positioned(
                //fix the image to the center of the screen
                left: MediaQuery.of(context).size.width / 2 - 50,
                top: MediaQuery.of(context).size.height / 2 - 50,

                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isOpen = true;
                    });

                    //show dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Congratulations!!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "You have completed the third level",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                ElevatedButton(
                                  child: Text(
                                    "Next Level",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.toNamed('/level4');
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    'assets/safe2.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                left: position.dx == 0
                    ? MediaQuery.of(context).size.width / 2 - 50
                    : position.dx + 100,
                top: position.dy == 0
                    ? MediaQuery.of(context).size.height / 2 - 50
                    : position.dy + 100,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      position = Offset(
                        position.dx + details.delta.dx,
                        position.dy + details.delta.dy,
                      );
                    });
                  },
                  child: _isOpen==false? Image.asset(
                    'assets/safe1.png',
                    width: 100,
                    height: 100,
                  ):Image.asset(
                    'assets/safe3.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
