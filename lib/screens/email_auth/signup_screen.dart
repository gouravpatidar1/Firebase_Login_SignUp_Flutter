
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/screens/email_auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();


  void createAccount() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if(email == "" || password == "" || cPassword==""){
      debugPrint("Please fill the details");
    }else if(password != cPassword){
      debugPrint("Password do not match");
    }else{

      
      // create new account 

      try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, password: password);
      if(userCredential.user != null){
        Navigator.pop(context);
      }  
      }on FirebaseAuthException catch(ex){
         debugPrint(ex.code.toString());
      }

    }
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        title: Text("Sign Up"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 52.h,),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      
                    ),
                  ),
                  SizedBox(height: 50.h,),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: cPasswordController,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r)
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        createAccount();
                      },
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14.h)),
                        backgroundColor: MaterialStatePropertyAll(Colors.purpleAccent),
                      ),
                       child: Text('Create Account')
                       ),
                  ),
                   SizedBox(height: 10,),
                   TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LoginScreen()
                          ));
                    },
                     child: Text("Already have an account",
                     style: TextStyle(
                      color: Colors.purpleAccent
                     ),),
                     ),  
                ],
              ), 
            )
          ],
        )
        ),
    );
  }
}