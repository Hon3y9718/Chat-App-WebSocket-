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
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Get.height * 0.65,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("lib/assets/frontpage1.jpg"),fit: BoxFit.fitHeight)),
              ),
              Container(height: Get.height*0.30,width: Get.width,decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),child: Column(children: [
                
                SizedBox(
                height: 24,
              ),
              Text(
                "Enjoy the new experience of\n chating with global friends",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 17,
              ),
              Text("Connect people around the world for free",
                  style: TextStyle(
                      fontSize: 15.5, color: Color.fromARGB(255, 71, 69, 69))),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap:  () {
                  Get.to(Dashboard());
                },
                child: Container(
                  decoration: (BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.purple,
                  )),
                  height: 50,
                  width: Get.width - 100,
                  margin: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 11,
              ),
              Text(
                "Powered by ussage",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
              ]),)
              
            ],
          ),
        ),
      ),
    );
  }
}
