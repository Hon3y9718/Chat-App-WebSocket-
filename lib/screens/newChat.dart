import 'package:chatproject/Constants.dart';
import 'package:chatproject/Controllers/ConnectionController.dart';
import 'package:chatproject/models/UserModel.dart';
import 'package:chatproject/screens/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewChat extends StatefulWidget {
  const NewChat({super.key});

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  var connection = Get.put(ConnectionController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Start Chat",
            style: TextStyle(color: Pallete.secondary),
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Pallete.primary,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: connection.contacts.isNotEmpty
            ? SizedBox(
                height: Get.height,
                child: Obx(
                  () => ListView.separated(
                      // shrinkWrap: true,
                      itemCount: connection.allMobile.length,
                      itemBuilder: (BuildContext context, int index) {
                        return connection.allMobile.isNotEmpty
                            ? ListTile(
                                onTap: () {
                                  UserModel user = UserModel(
                                      name: connection
                                          .allMobile[index].displayName,
                                      id: connection
                                          .allMobile[index].phones![0].value
                                          .toString()
                                          .replaceAll("+91", "")
                                          .replaceAll(" ", "")
                                          .trim(),
                                      msglist: []);
                                  Get.to(() => ChatPage(
                                        user: user,
                                      ));
                                },
                                title: Text(
                                    "${connection.allMobile[index].displayName}"),
                                subtitle: connection
                                        .allMobile[index].phones!.isNotEmpty
                                    ? Text(
                                        "${connection.allMobile[index].phones![0].value}")
                                    : const Text(""),
                                leading: CircleAvatar(
                                  backgroundColor: Pallete.secondary,
                                  child: Text(
                                    connection.allMobile[index].displayName![0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container();
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          connection.allMobile.isNotEmpty
                              ? const Divider(
                                  color: Color.fromARGB(255, 135, 128, 128),
                                )
                              : Container()),
                ),
              )
            : connection.isLoadingContacts.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  )
                : const Center(
                    child: Text("No Contacts!"),
                  ),
      ),
    );
  }
}
