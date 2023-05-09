import 'package:chatproject/screens/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(231, 244, 250, 254),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0)),
                  color: Colors.white,
                ),
                height: 100,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            color: Colors.white,
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () {Get.to(Dashboard());},
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Padding(
                               padding: const EdgeInsets.only(left:8.0, right: 10),
                               child: CircleAvatar(backgroundImage: AssetImage("lib/assets/pic.jpg"),),
                             ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('  Sebastian Rudiger',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text('  Online',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.green))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            color: Colors.white,
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.video_call_rounded,
                                color: Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                        Container(
                            color: Colors.white,
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.call,
                                color: Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {},
                            )),
                      ],
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      chatBox(context, 'Hi, Jimmy! Any update today?', false),
                      chatBox(context, "All good! we have some update", true)
                    ],
                  );
                },
              ),
            ],
          ),
          Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0)),
                color: Colors.white,
              ),
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color.fromARGB(231, 244, 250, 254),
                      ),
                      height: 60,
                      width: Get.width * 0.7,
                      child: const Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type here...."),
                        ),
                      )),
                  const SizedBox(height: 30, width: 1),
                  Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Color.fromARGB(231, 244, 250, 254),
                      ),
                      height: 60,
                      width: 80,
                      child: IconButton(
                        iconSize: 20,
                        icon: const Icon(
                          Icons.send,
                          color: Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {},
                      ))
                ],
              ))
        ],
      )),
    );
  }
}

Widget chatBox(BuildContext context, text, isSender) {
  return Align(
    alignment: isSender ? Alignment.topRight : Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 25, left: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: const Radius.circular(15.0),
                topLeft: const Radius.circular(15.0),
                bottomLeft: Radius.circular(isSender ? 15.0 : .0),
                bottomRight: Radius.circular(isSender ? 0 : 15.0)),
            color: isSender
                ? const Color.fromARGB(255, 103, 42, 234)
                : Colors.white,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isSender ? Colors.white : Colors.black,
              fontFamily: 'Roboto_Black',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0, top: 10),
          child: Text(
            '09:34 PM',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: 'Roboto_Black',
            ),
          ),
        ),
      ],
    ),
  );
}
