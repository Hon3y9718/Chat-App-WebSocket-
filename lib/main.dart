import 'package:chatproject/screens/ChatPage.dart';
import 'package:chatproject/screens/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/HomePage.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat App Prototype",home: HomePage(),
    );
    
  }
}