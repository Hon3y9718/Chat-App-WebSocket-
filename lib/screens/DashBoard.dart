import 'package:chatproject/Constants.dart';
import 'package:chatproject/Controllers/ConnectionController.dart';
import 'package:chatproject/Controllers/Store.dart';
import 'package:chatproject/models/UserModel.dart';
import 'package:chatproject/screens/ChatPage.dart';
import 'package:chatproject/screens/newChat.dart';
import 'package:chatproject/widgets/chatCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var connection = Get.put(ConnectionController());
  TextEditingController searchController = TextEditingController();
  var store = Store();
  var _searchList = [];

  secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  final GlobalKey<State<ChatPage>> _key = GlobalKey();

  @override
  void initState() {
    connection.key = _key;
    getChats();
    secureScreen();
    super.initState();
  }

  getChats() async {
    await connection.getOldMsg();
    setState(() {});
  }

  search(text) {
    if (text.isBlank) {
      setState(() {
        _searchList = connection.msglist.value;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chats",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              getChats();
            },
            icon: const Icon(
              Icons.refresh_rounded,
              color: Pallete.secondary,
            ),
          ),
          Obx(
            () => connection.connected.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 5,
                    ),
                  ),
          )
        ],
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0.2,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("New Chat"),
        backgroundColor: Pallete.secondary,
        onPressed: () {
          Get.to(() => const NewChat());
        },
        icon: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getChats();
        },
        child: connection.msglist.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/chat.png"),
                ],
              )
            : SizedBox(
                height: Get.height,
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    itemCount: connection.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return connection.users[index].msglist!.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                Get.to(() => ChatPage(
                                      user: connection.users[index],
                                      key: connection.key,
                                    ));
                              },
                              child: chatCard(
                                context,
                                fileName: connection
                                    .users[index].msglist!.last.fileName,
                                user: connection.users[index],
                                id: connection.users[index].id,
                                name: connection.users[index].name == ""
                                    ? "${connection.users[index].id}"
                                    : connection.users[index].name,
                                lastMessage: connection
                                    .users[index].msglist!.last.msgtext,
                                time: DateTime.parse(connection
                                        .users[index].msglist!.last.date!)
                                    .toLocal(),
                              ),
                            )
                          : Container();
                    },
                    separatorBuilder: (BuildContext context, int chatIndex) =>
                        const Divider(
                      endIndent: 30,
                      indent: 30,
                      color: Color.fromARGB(64, 135, 128, 128),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
