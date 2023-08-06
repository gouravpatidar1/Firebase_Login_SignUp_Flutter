import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/home_screen.dart';
import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  const VerifyOtpScreen({Key? key, required this.verificationId}): super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: widget.verificationId, smsCode: otp);

    try{
      UserCredential userCredential = await FirebaseAuth.instance.
      signInWithCredential(credential);
      if(userCredential.user != null){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => HomeScreen()));
      }

    }on FirebaseAuthException catch(ex){
      debugPrint(ex.code.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(children: [
          TextField(
            maxLength: 6,
            controller: otpController,
            decoration: InputDecoration(
              labelText: "6 Digit OTP",
              counterText: ""
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            verifyOTP();
          }, child: Text("Verify")),
        ],)
        ),
    );
  }
}