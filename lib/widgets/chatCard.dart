import 'package:chatproject/Constants.dart';
import 'package:chatproject/screens/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

Widget chatCard(BuildContext context,
    {name, lastMessage, time, id, user, fileName}) {
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
                    backgroundColor: const Color.fromARGB(255, 50, 46, 77),
                    child: Text(
                      "${name[0]}",
                      style: const TextStyle(color: Colors.white),
                    ),
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
                        SizedBox(
                          width: Get.width * 0.5,
                          child: fileName == null
                              ? Text(
                                  lastMessage ?? "",
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 103, 101, 101)),
                                )
                              : Row(
                                  children: const [
                                    Icon(
                                      Icons.photo,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Photo",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
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
