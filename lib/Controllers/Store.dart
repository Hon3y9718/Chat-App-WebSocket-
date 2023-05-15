import 'dart:convert';
import 'dart:io';
import 'package:chatproject/models/UserModel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

class Store {
  var db = GetStorage();

  readData() {
    var data = db.read("history");
    print("DataONRead: $data");
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  writeData(newData) async {
    db.write("history", null);
    db.write("history", jsonEncode(newData));
    print("WriteData: $newData");
    print("IsDataStored: ${db.read("history")}");
  }

  Future<List<UserModel>> getAllChatForDashboard() async {
    var data = readData() ?? [];
    print("DataOnDash: $data");
    List<UserModel> users = [];
    if (data != null) {
      data.forEach((element) {
        var u = UserModel.fromJson(element);

        users.add(u);
      });
    }
    return users;
  }

  addNewMessage({id, msg}) async {
    var userFound = false;
    var data = readData() ?? [];
    print("DataFromHistory: $data");
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
    var data = readData() ?? [];
    var messages = [];
    if (data != null) {
      data.forEach((element) {
        element['msglist']
            .forEach((item) => {messages.add(Msglist.fromJson(item))});
      });
    }
    return messages;
  }

  addNewChat({name, id}) {}
}
