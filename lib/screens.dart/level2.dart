import 'package:elitmus_project/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_details.dart';
import 'helper/numPad.dart';

class Level2 extends StatefulWidget {
  const Level2({super.key});

  @override
  State<Level2> createState() => _Level2State();
}

class _Level2State extends State<Level2> {
  final userdate = GetStorage();
  final controller = Get.put(ProfileController());
  int score = 0;
  final TextEditingController _myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    score = int.parse(userdate.read('score'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 2 "R"'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // display the a Text with bold letters
          const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Can you solve this question?\n\n        1+2+3+1\n        1+2+3+1\n       1+2+3+1=?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ElevatedButton(
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
                      'Oh No!! the some next line is printed in wrong place in question.\n Concatenate the lines and solve the question.',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              );

              setState(() {
                // score = "9000";
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

          // display the entered numbers
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 70,
              child: Center(
                  child: TextField(
                controller: _myController,
                textAlign: TextAlign.center,
                showCursor: false,
                style: const TextStyle(fontSize: 40),
                // Disable the default soft keybaord
                keyboardType: TextInputType.none,
              )),
            ),
          ),
          // implement the custom NumPad
          NumPad(
            buttonSize: 75,
            buttonColor: Colors.blue,
            iconColor: Colors.deepOrange,
            controller: _myController,
            delete: () {
              _myController.text = _myController.text
                  .substring(0, _myController.text.length - 1);
            },
            // do something with the input numbers
            onSubmit: () {
              // if user submit certain number show dialog check condition

              if (_myController.text == '39') {
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
                              "You have completed the second level",
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
                                Get.toNamed('/level3');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                debugPrint('Your code: ${_myController.text}');
                //show bottom sheet
                Get.bottomSheet(
                  Container(
                    height: 100,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Wrong Answer',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
