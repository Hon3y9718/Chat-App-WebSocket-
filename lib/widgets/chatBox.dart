import 'dart:convert';

import 'package:chatproject/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget chatBox(BuildContext context, {text, date, isSender, fileName}) {
  date ??= DateTime.now();

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
            color: isSender ? Pallete.primary : Colors.white,
          ),
          child: fileName != null
              ? Image.memory(base64Decode(text))
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSender ? Colors.white : Colors.black,
                    fontFamily: 'Roboto_Black',
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 10),
          child: Text(
            DateFormat("hh:mm a").format(date.toLocal()),
            style: const TextStyle(
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
