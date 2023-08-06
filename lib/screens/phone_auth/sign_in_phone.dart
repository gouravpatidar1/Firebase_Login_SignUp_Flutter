

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/screens/phone_auth/verify_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({super.key});

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {

  TextEditingController phoneController = TextEditingController();

  void sendOTP() async {
    String phone = "+91" + phoneController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: ((verificationId, forceResendingToken) => {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => VerifyOtpScreen(verificationId: verificationId,)))
      }),
      verificationCompleted: (Credential) {},
      verificationFailed: (ex){
      debugPrint(ex.code.toString());
      },
      codeAutoRetrievalTimeout: ((verificationId) => {}),
      timeout: Duration(seconds: 30),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Sign In"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListView(
              children: [
                SizedBox(height: 52.h,),
                  Text(
                    "Login with Phone",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      
                    ),
                  ),
                  SizedBox(height: 50.h,),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    )
                  ),
                ),
                SizedBox(height: 50.h,),
                SizedBox(
                  width: double.infinity,
                  
                  child: ElevatedButton(onPressed: (){
                       sendOTP(); 
                  },
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14.h)),
                    backgroundColor: MaterialStatePropertyAll(Colors.purpleAccent),
                  ),
                  child: Text("Verify OTP",)),
                )
            ]
            ),
        )
         ),
    );
  }
}