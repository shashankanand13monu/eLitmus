import 'package:elitmus_project/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_details.dart';

class Level4 extends StatefulWidget {
  @override
  _Level4State createState() => _Level4State();
}

class _Level4State extends State<Level4> {
  Offset position = Offset.zero;
  final userdate = GetStorage();
  final controller = Get.put(ProfileController());
  int score = 0;
  //Text controller for the text field
  int count = 0;
  @override
  Widget build(BuildContext context) {
    score=int.parse(userdate.read('score'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 4 "D"'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // A text with big bold letters above the image
            Text(
              'Press 1000',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // A text to display count in big bold letter with black border
            Text(
              '$count',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                shadows: [
                  Shadow(
                    blurRadius: 50.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            
            Container(
              height: 600,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // A text with big bold letters above the image

                  // A text field to display the entered numbers

                  Positioned(
                    //fix the image to the center of the screen
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    top: MediaQuery.of(context).size.height / 2 - 50,

                    child: GestureDetector(
                      onTap: () {
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
              "You have completed the fourth level",
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
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                Get.toNamed('/level5');
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
                        'assets/but2.png',
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
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            count++;
                          });

                          if(count%20==0)
                          {
                            //show bottom sheet that "Are you really gonna tap till 1000?"
                            Get.bottomSheet(
                Container(
                  height: 100,
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      'Are you really gonna tap till 1000?',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              );
                          


                            
                          }
                        },
                        child: Image.asset(
                          'assets/but1.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                ],
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
                        'Is there any other button here?',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                );

                setState(() {
                 score = score - 1500;
                userdate.write('score', score.toString());

                });
                final userData= UserModel(
    name: userdate.read('name'),
    email: userdate.read('email'),
    score: int.parse(userdate.read('score')),
  );
                await controller.updateScore(userData);
              },
            ),
          ],
        ),
      ),
    );
  }
}
