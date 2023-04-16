import 'package:elitmus_project/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_details.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  final userdate = GetStorage();
  final controller = Get.put(ProfileController());
  int score = 0;
  

  @override
  Widget build(BuildContext context) {
    score=int.parse(userdate.read('score'));
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Level One "V"'),
        actions: [
          FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  print(userdate.read('email'));
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
        children: [
          SizedBox(
            height: 20,
          ),
          //a text widget with the text "Select the Darkest Color" in big bold letters
          Center(
            child: GestureDetector(
              onTap: () {
                //show a dialog box with teh text that "Wrong Color Selected" ios style cupertino icons
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
                              "You have completed the first level",
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
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed('/level2');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                "Click on  the Darkest Color",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              // a size of half the screen
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width / 4,
              child: Center(
                //a matrix with 25 different shades of pink color(visible to eye and diffrentiable) with space between them
                child: GridView.count(
                  crossAxisCount: 5,
                  children: List.generate(25, (index) {
                    return GestureDetector(
                      onTap: () {
                        //show a bootom sheet
                        Get.bottomSheet(
                          Container(
                            height: 100,
                            color: Colors.blue,
                            child: const Center(
                              child: Text(
                                'Wrong Color Selected',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.all(5),
                        color: Color.fromARGB(
                            255, 255, 255 - index * 10, 255 - index * 10),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          // A hint button that shows a dialog box with the text "The darkest color is the one that is closest to black" and on tapping it score is decreased by 1000
          Center(
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
                        'The darkest color is the one that is closest to black',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                );
                

                setState(()  {
                  // score = "9000";
                  int s= score;
                  s=s-1000;
                  
                userdate.write('score', s.toString());
                score=s;
                 



                });
                final userData= UserModel(
    name: userdate.read('name'),
    email: userdate.read('email'),
    score: int.parse(userdate.read('score')),
  );
                await controller.updateScore(userData);

              },
            ),
          ),
        ],
      ),
    );
  }
}
