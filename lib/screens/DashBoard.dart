import 'package:chatproject/screens/ChatPage.dart';
import 'package:chatproject/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromARGB(231, 244, 250, 254),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.78,
                      child: TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(12)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 2.0),
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 73, 69, 69),
                            ),
                            hintText: "Search message..."),
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Container(
                        padding: const EdgeInsets.all(1),
                        height: 60,
                        width: Get.width * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 170, 167, 167)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.open_in_new_outlined,color: Color.fromARGB(255, 73, 69, 69),)))
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int chatIndex) {
                    return chatCard(context);
                  },
                  separatorBuilder: ( BuildContext context, int chatIndex) => Divider(color: Color.fromARGB(255, 135, 128, 128),) ,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget chatCard(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0),
    child: GestureDetector(onTap: () {
      Get.to(ChatPage());
    },
      child: SizedBox(
        height: 90,
        width: 40,
        child: Card(
            elevation: 0.0,
            child: Row( 
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15),
                  child: SizedBox( height: 90, width: Get.width*0.10,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("lib/assets/pic.jpg"),
                    ),
                  ),
                ),SizedBox(height: 90,width: Get.width*0.75,
                  child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sebastian Rudiger",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("Perfect will check it",style: TextStyle(color: Color.fromARGB(255, 103, 101, 101)),)
                        ],
                      ),Column(
                  mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("09:34 PM", style: TextStyle(color: Colors.grey)),
                    Icon(
                      Icons.circle,
                      color: Colors.purple,
                    )
                  ],
                )
                    ],
                  ),
                ),
              ],
            )),
      ),
    ),
  );
}

              