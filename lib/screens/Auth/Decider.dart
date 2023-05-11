import 'package:chatproject/screens/DashBoard.dart';
import 'package:chatproject/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Decider extends StatefulWidget {
  const Decider({super.key});

  @override
  State<Decider> createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var db = GetStorage();
      var isLogin = db.read("isLoggedIn");
      if (isLogin != null) {
        if (isLogin) {
          Get.to(() => const Dashboard());
        } else {
          Get.to(() => const HomePage());
        }
      } else {
        Get.to(() => const HomePage());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      ),
    );
  }
}
