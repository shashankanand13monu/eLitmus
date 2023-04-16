import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_details.dart';
import '../models/usermodel.dart';


class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LeaderBoard'),
      ),
      body:  FutureBuilder(
        future: controller.getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) { 
          if(snapshot.hasData){
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 500,
                      width: 600,
                      child: ListView.builder(
                        
              
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            tileColor: index%2==0?Color.fromARGB(255, 123, 184, 245):Colors.white,
                            focusColor: Colors.lightBlue,
                            title: Text(snapshot.data![index].name!),
                            trailing: Text(snapshot.data![index].score.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
         },
        
      ),
    );
  }
}