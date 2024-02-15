import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();
final passwordCheckController = TextEditingController();
DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");

class HandleControllers {



}