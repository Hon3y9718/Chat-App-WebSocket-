import 'package:chatproject/screens/DashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var isOtpSent = false;
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  String? verificationID = null;

  FirebaseAuth auth = FirebaseAuth.instance;
  var db = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Mobile Number"),
        backgroundColor: Colors.purple,
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
            SizedBox(
              width: Get.width * 0.9,
              child: TextField(
                controller: mobileNumber,
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
                      Icons.phone,
                      color: Color.fromARGB(255, 73, 69, 69),
                    ),
                    hintText: "Enter Mobile Number"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isOtpSent
                ? SizedBox(
                    width: Get.width * 0.9,
                    child: TextField(
                      controller: otp,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
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
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            isOtpSent == false
                ? ElevatedButton(
                    onPressed: () async {
                      await auth.verifyPhoneNumber(
                        phoneNumber:
                            "+91${mobileNumber.text.trim().replaceAll("+91", "")}",
                        codeSent: (verificationId, forceResendingToken) {
                          setState(() {
                            isOtpSent = true;
                            verificationID = verificationId;
                            print("VERIFICATION: $verificationId");
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                        verificationCompleted:
                            (PhoneAuthCredential phoneAuthCredential) {},
                        verificationFailed: (FirebaseAuthException error) {},
                      );
                    },
                    child: Text("Submit"),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        print("VERIFICATION: $verificationID");
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationID!,
                                smsCode: otp.text.trim());
                        var user = await auth.signInWithCredential(credential);
                        print(user);
                        print(user.user);
                        if (user.user != null) {
                          db.write("userId",
                              mobileNumber.text.trim().replaceAll("+91", ""));
                          db.write("isLoggedIn", true);
                          Get.to(() => const Dashboard());
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text("Submit"),
                  ),
          ],
        ),
      ),
    );
  }
}
