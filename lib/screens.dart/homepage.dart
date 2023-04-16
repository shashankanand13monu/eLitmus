import 'package:elitmus_project/controllers/user_details.dart';
import 'package:elitmus_project/models/usermodel.dart';
import 'package:elitmus_project/screens.dart/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userdate = GetStorage();
    int score = 0;

    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        //Display Score and Logout Button
        // with future builder
        actions: [
          FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  print(userdate.read('email'));
                  userdate.write('score', userData.score.toString());
                  userdate.write('id', userData.id.toString());

                  return Center(
                    child: Text(
                      'Score: ${userData.score}',
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

              child: Text('Leader Board',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () {
                //logout
                Get.to(LeaderBoard(), transition: Transition.topLevel);
              },
            ),
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

        actionsIconTheme: null,
        centerTitle: true,
        title: Text('Welcome to Tresure Hunt Game'),
      ),
      body: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              print(snapshot.data);
              print(userData.score);
              print(userData.name);

              print(userdate.read('email'));
              userdate.write('score', userData.score.toString());

              return Center(
                //a stat button
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    //Rules to explain the game
                    Container(
                      child: Text(
                        'Rules',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        '1. Pass all 5 Levels\n2. Look out for secret clues\n3. Every Hint you take,some points will be deducted everytime\n4. Score the Highest. Have Fun!!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      child: FloatingActionButton(
                        child: Text(
                          'Start',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        splashColor: Colors.white,
                        onPressed: () {
                          Get.toNamed('/level1');
                        },
                        backgroundColor: Color.fromARGB(255, 0, 83, 250),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      child: FloatingActionButton(
                        child: Text(
                          'LeaderBoard',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        splashColor: Colors.white,
                        onPressed: () {
                          Get.to(LeaderBoard());
                        },
                        backgroundColor: Color.fromARGB(255, 241, 9, 86),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      child: FloatingActionButton(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        splashColor: Colors.white,
                        onPressed: () {
                          Get.find<AuthController>().signout();
                        },
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                  ],
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
    );
  }
}
