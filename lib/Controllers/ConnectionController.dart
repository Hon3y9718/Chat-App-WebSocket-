import 'dart:convert';

import 'package:chatproject/Constants.dart';
import 'package:chatproject/Controllers/Store.dart';
import 'package:chatproject/models/MessageData.dart';
import 'package:chatproject/models/UserModel.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/io.dart';

class ConnectionController extends GetxController {
  GlobalKey key = GlobalKey();

  var db = GetStorage();
  var resize = false.obs;
  var store = Store();
  RxList users = [].obs;

  @override
  void onInit() {
    if (db.read("isLoggedIn") != null) {
      myid = db.read("userId");
      getOldMsg();
      channelconnect();

      getContacts();
    }
    super.onInit();
  }

  getOldMsg() async {
    users.value = await store.getAllChatForDashboard();
    msglist.value = await store.getAllMessages();
    print("callling Old Messages");
    if (contacts.isNotEmpty) {
      for (UserModel user in users) {
        for (Contact c in contacts) {
          if (c.phones!.isNotEmpty) {
            if (c.phones![0].value!
                    .replaceAll(" ", "")
                    .replaceAll("+91", "")
                    .trim() ==
                user.id) {
              user.name = c.displayName;
            }
          }
        }
      }
      store.writeData(users.value);
    }
  }

  late IOWebSocketChannel channel; //channel varaible for websocket
  RxBool connected = false.obs; // boolean value to track connection status

  String myid = "222"; //my id
  String recieverid = "7777"; //reciever id
  // swap myid and recieverid value on another mobile to test send and recieve
  String auth = "chatapphdfgjd34534hjdfk"; //auth key

  RxList msglist = [].obs;

  RxString? msgtext = "".obs;

  var usersOnServer = [].obs;

  channelconnect() {
    //function to connect
    try {
      channel = IOWebSocketChannel.connect(
          "${Constant.WEBSOCKETURL}/$myid"); //channel IP : Port
      print("Connecting to: ${Constant.WEBSOCKETURL}/$myid");
      channel.stream.listen(
        (message) async {
          print(message);
          if (message == "connected") {
            connected.value = true;
            getUsersOnServer();
            print("Connection establised.");
          } else if (message == "send:success") {
            print("Message send success");
            msgtext!.value = "";
          } else if (message == "send:error") {
            print("Message send error");
            Get.snackbar("User Offline",
                "User is Offline, they can not receive message right now.");
          } else if (message.substring(0, 6) == "{'cmd'") {
            print("Message data");
            message = message.replaceAll(RegExp("'"), '"');
            var jsondata = json.decode(message);

            if (jsondata['cmd'] == "getUsers") {
              usersOnServer.value = jsondata['users'];
              getContacts();
            } else if (jsondata['cmd'] == "sendImage") {
              var msg = Msglist.fromJson(jsondata);
              store.addNewMessage(id: msg.from, msg: msg);
              getOldMsg();
              msglist.add(msg);
              msgtext!.value = "";
            } else {
              var msg = Msglist.fromJson(jsondata);
              store.addNewMessage(id: msg.from, msg: msg);
              getOldMsg();
              msglist.add(msg);
              msgtext!.value = "";
            }
          }
        },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");

          connected.value = false;
        },
        onError: (error) {
          print(error.toString());
        },
      );
    } catch (_) {
      print("error on connecting to websocket.");
    }
  }

  Future<void> sendmsg(String sendmsg, String id) async {
    if (connected.value == true) {
      String msg =
          "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg','from':'$myid', 'date':'${DateTime.now().toUtc()}'}";
      print(msg);
      msgtext!.value = "";
      var mymsg = Msglist(
          msgtext: sendmsg,
          userid: id,
          from: myid,
          auth: auth,
          fileName: null,
          date: DateTime.now().toUtc().toString());
      msglist.add(mymsg);

      store.addNewMessage(id: id, msg: mymsg);

      channel.sink.add(msg); //send message to reciever channel
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  Future<void> sendImg(String sendmsg, String id, String fileName) async {
    if (connected.value == true) {
      String msg =
          "{'auth':'$auth','fileName':'$fileName','cmd':'sendImage','userid':'$id', 'msgtext':'$sendmsg','from':'$myid', 'date':'${DateTime.now().toUtc()}'}";
      print(msg);
      msgtext!.value = "";
      var mymsg = Msglist(
          msgtext: sendmsg,
          userid: id,
          from: myid,
          auth: auth,
          fileName: fileName,
          date: DateTime.now().toUtc().toString());
      msglist.add(mymsg);

      store.addNewMessage(id: id, msg: mymsg);

      channel.sink.add(msg); //send message to reciever channel
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  Future<void> getUsersOnServer() async {
    if (connected.value == true) {
      String msg =
          "{'auth':'$auth','cmd':'getUsers','userid':'$myid', 'date':'${DateTime.now().toUtc()}'}";

      msgtext!.value = "";

      channel.sink.add(msg); //send message to reciever channel
    } else {
      channelconnect();
      print("Websocket is not connected.");
    }
  }

  askPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.contacts].request();
  }

  RxList contacts = [].obs;
  var allMobile = [].obs;
  RxBool isLoadingContacts = true.obs;

  getContacts() async {
    await askPermission();
    contacts.value = await ContactsService.getContacts();
    allMobile.clear();
    for (var element in contacts) {
      if (element.phones!.isNotEmpty) {
        if (usersOnServer.contains(element.phones![0].value!
            .trim()
            .replaceAll("+91", "")
            .replaceAll(" ", "")
            .trim())) {
          allMobile.add(element);
        }
      }
    }
    isLoadingContacts.value = false;
  }
}
