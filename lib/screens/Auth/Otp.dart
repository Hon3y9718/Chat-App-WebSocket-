import 'package:chatproject/Constants.dart';
import 'package:chatproject/screens/DashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OTP extends StatefulWidget {
  const OTP(
      {super.key, required this.verificationID, required this.mobileNumber});
  final verificationID;
  final mobileNumber;
  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var isOtpSent = false;
  // TextEditingController mobileNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  // String? verificationID = null;

  FirebaseAuth auth = FirebaseAuth.instance;
  var db = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(color: Pallete.primary),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Start your experience of\n chatting securely with friends",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 17,
            ),
            const Text(
              "Connect people around the world for free",
              style: TextStyle(
                fontSize: 15.5,
                color: Color.fromARGB(255, 71, 69, 69),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width * 0.9,
              child: TextField(
                controller: otp,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(20)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueGrey, width: 2.0),
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: Color.fromARGB(255, 73, 69, 69),
                    ),
                    hintText: "Enter OTP"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  print("VERIFICATION: ${widget.verificationID}");
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationID!,
                      smsCode: otp.text.trim());
                  var user = await auth.signInWithCredential(credential);
                  print(user);
                  print(user.user);
                  if (user.user != null) {
                    db.write("userId",
                        widget.mobileNumber.trim().replaceAll("+91", ""));
                    db.write("isLoggedIn", true);
                    Get.to(() => const Dashboard());
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                decoration: (BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Pallete.secondary,
                )),
                height: 50,
                width: Get.width - 100,
                margin: const EdgeInsets.all(8),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
