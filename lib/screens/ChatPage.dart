import 'package:chatproject/Controllers/ConnectionController.dart';
import 'package:chatproject/models/UserModel.dart';
import 'package:chatproject/screens/DashBoard.dart';
import 'package:chatproject/widgets/chatBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var connection = Get.put(ConnectionController());
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: connection.msglist.length > 1 ? true : true,
      backgroundColor: const Color.fromARGB(231, 244, 250, 254),
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 100),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)),
              color: Colors.white,
            ),
            height: 80,
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
                          onPressed: () {
                            Get.to(() => const Dashboard());
                          },
                        )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: widget.user.name!.isNotEmpty
                                ? Text(widget.user.name![0])
                                : Text(widget.user.id![0]),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${widget.user.name!.isNotEmpty ? widget.user.name : widget.user.id}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            height: Get.height * 0.74,
            child: GlowingOverscrollIndicator(
              color: Colors.purpleAccent,
              axisDirection: AxisDirection.down,
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: connection.msglist.length,
                  itemBuilder: (context, index) {
                    return connection.msglist[index].from != null
                        ? connection.msglist[index].from! == widget.user.id &&
                                    connection.msglist[index].userid! ==
                                        connection.myid ||
                                connection.msglist[index].from! ==
                                        connection.myid &&
                                    connection.msglist[index].userid! ==
                                        widget.user.id
                            ? chatBox(context,
                                date: DateTime.parse(
                                    connection.msglist[index].date!),
                                isSender: connection.msglist[index].userid ==
                                        connection.myid
                                    ? false
                                    : true,
                                text: connection.msglist[index].msgtext)
                            : Container()
                        : Container();
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0)),
                color: Colors.white,
              ),
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color.fromARGB(231, 244, 250, 254),
                      ),
                      height: 60,
                      width: Get.width * 0.7,
                      child: Center(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
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
                        onPressed: () async {
                          await connection.sendmsg(
                              messageController.text, widget.user.id!);
                          messageController.clear();
                        },
                      ))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
