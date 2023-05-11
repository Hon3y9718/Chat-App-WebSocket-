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
    secureScreen();
    super.initState();
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
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (text) {
                      search(text);
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(30)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2.0),
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 73, 69, 69),
                        ),
                        hintText: "Search..."),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(
                  () => CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        connection.connected.value ? Colors.green : Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Get.to(() => const NewChat());
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await connection.getOldMsg();
        },
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
                        user: connection.users[index],
                        id: connection.users[index].id,
                        name: connection.users[index].name == ""
                            ? "${connection.users[index].id}"
                            : connection.users[index].name,
                        lastMessage:
                            connection.users[index].msglist!.last.msgtext,
                        time: DateTime.parse(
                            connection.users[index].msglist!.last.date!),
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
    );
  }
}
