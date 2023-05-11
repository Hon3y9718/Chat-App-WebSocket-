import 'package:chatproject/screens/Auth/SignIn.dart';
import 'package:chatproject/screens/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Get.height * 0.6,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/frontpage1.jpg"),
                      fit: BoxFit.fitHeight),
                ),
              ),
              Container(
                height: Get.height * 0.30,
                width: Get.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(18)),
                child: Column(children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Enjoy the experience of\n chatting securely with friends",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  const Text("Connect people around the world for free",
                      style: TextStyle(
                          fontSize: 15.5,
                          color: Color.fromARGB(255, 71, 69, 69))),
                  const SizedBox(
                    height: 22,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignIn());
                    },
                    child: Container(
                      decoration: (BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.purple,
                      )),
                      height: 50,
                      width: Get.width - 100,
                      margin: const EdgeInsets.all(8),
                      child: const Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
