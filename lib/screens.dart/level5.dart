//import material dart
import 'package:elitmus_project/models/usermodel.dart';
import 'package:elitmus_project/screens.dart/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import http
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_details.dart';

class Level5 extends StatefulWidget {
  const Level5({super.key});

  @override
  State<Level5> createState() => _Level5State();
}

class _Level5State extends State<Level5> {
  //Text controller for the text field
  TextEditingController _controller = TextEditingController();
  final userdate = GetStorage();
  final controller = Get.put(ProfileController());
  int score = 0;
  @override
  Widget build(BuildContext context) {
    score = int.parse(userdate.read('score'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Level 5 - Final Level "A"'),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Here, This is your Code to Win this game',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                'Are you smart enough to crack it?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 20,
              ),
              // show the assests image
              Image.asset(
                'assets/tanenc.png',
                height: 400,
                width: 400,
              ),
              SizedBox(
                height: 20,
              ),
              // a big download button with round rectangle border and download icon on the left , On clicking it the image will be downloaded
              Container(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    const url =
                        'https://drive.google.com/uc?export=download&id=1K28tjKIKi4PC8D8YUUggrbp9zI3NA4go';

                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    } else {
                      Get.snackbar("Error", "Unable to download the file");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.download),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Download'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),

              // a big button with round rectangle border with text "Enter Code"
              SizedBox(
                height: 20,
              ),
              // a text field with round rectangle border
              Container(
                width: 150,
                height: 40,
                child: TextField(
                  controller: _controller,
                  // make all characters uppercase
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    //check if the code is correct
                    //convert text to uppercase
                    if (_controller.text.toUpperCase() == 'AANTY') {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Congratulations!!",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "You have successfully\ncompleted the game",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.to(LeaderBoard());
                                      },
                                      child: Text('Leaderboard'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      //show snackbar
                      Get.snackbar("Error", "Wrong Code",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  },
                  child: Text('Enter Code'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Decryption: at the receiver side, the cipher image is converted into a plain image utilizing a decryption approach and a secret key",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  const url =
                                      'https://decrypt.imageonline.co/index.php';

                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    Get.snackbar(
                                        "Error", "Unable to download the file");
                                  }
                                },
                                child: Text(
                                  "Decrypt",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });

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
            ],
          ),
        ),
      ),
    );
  }
}
