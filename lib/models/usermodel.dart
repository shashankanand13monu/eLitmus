import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final int? score;

  const UserModel({this.id,this.name, this.email, this.score});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      score: json['score'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data['name'],
      email: data['email'],
      score: data['score'],
    );
    
  }

  Map<String, dynamic> toJson() => {
        
        'name': name,
        'email': email,
        'score': score,
      };
  
 
}