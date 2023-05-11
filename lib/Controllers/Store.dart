import 'dart:convert';
import 'dart:io';
import 'package:chatproject/models/UserModel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class Store {
  var db = GetStorage();

  readData() async {
    var data = await db.read("history");
    return jsonDecode(data);
  }

  writeData(newData) async {
    db.write("history", jsonEncode(newData));
    print(newData);
  }

  Future<List<UserModel>> getAllChatForDashboard() async {
    var data = await readData();
    print(data);
    List<UserModel> users = [];
    data.forEach((element) {
      var u = UserModel.fromJson(element);

      users.add(u);
    });
    return users;
  }

  addNewMessage({id, msg}) async {
    var userFound = false;
    var data = await readData();
    data.forEach((element) {
      if (element['id'] == id) {
        element['msglist'].add(msg.toJson());
        userFound = true;
      }
    });
    if (userFound == false) {
      data.add({
        "name": "",
        "id": "$id",
        "msglist": [msg.toJson()]
      });
    }
    writeData(data);
  }

  getAllMessages() async {
    var data = await readData();
    var messages = [];
    data.forEach((element) {
      element['msglist']
          .forEach((item) => {messages.add(Msglist.fromJson(item))});
    });
    return messages;
  }

  addNewChat({name, id}) {}
}
