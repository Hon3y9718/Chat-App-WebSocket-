import 'package:chatproject/screens/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

Widget chatCard(BuildContext context, {name, lastMessage, time, id, user}) {
  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: SizedBox(
      // height: 90,
      width: 40,
      child: Card(
          elevation: 0.0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 15),
                child: SizedBox(
                  // height: 90,
                  width: Get.width * 0.10,
                  child: CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Text("${name[0]}"),
                  ),
                ),
              ),
              SizedBox(
                // height: 90,
                width: Get.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          lastMessage,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 103, 101, 101)),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(DateFormat("hh:mm a").format(time),
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}
