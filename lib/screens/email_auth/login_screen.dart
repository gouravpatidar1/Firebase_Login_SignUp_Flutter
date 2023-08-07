import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/home_screen.dart';
import 'package:firebase_practice/screens/email_auth/signup_screen.dart';
import 'package:firebase_practice/screens/phone_auth/sign_in_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email =="" || password ==""){
      debugPrint("Please fill all feilds");
    }else{

      try{
      UserCredential userCredential = await  FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);

        if(userCredential.user != null){

          Navigator.popUntil(context, (route) => route.isFirst);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }

      }on FirebaseAuthException catch(ex){
        debugPrint(ex.code.toString());
      }  
    }
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        title: Text("Login"),
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
                  LoginText(),
                  SizedBox(height: 50.h,),
                  emailFeild(),
                  SizedBox(height: 20.h,),
                  passwordFeild(),
                  SizedBox(height: 50.h,),
                  loginButton(),
                  SizedBox(height: 5.h,),
                  createAccount(),
                  loginOnPhone(),
                ],
              ), 
            )
          ],
        )
        ),
    );
  }

  Widget emailFeild(){
    return TextField(
            controller: emailController,
            decoration: InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r)
                ),
             ),
         );
  }
  Widget passwordFeild(){
    return TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r)
                      ),
                      labelText: "Password"
                    ),
                  );
  }

  Widget loginButton(){
    return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        login();
                      },
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14.h)),
                        backgroundColor: MaterialStatePropertyAll(Colors.purpleAccent),
                      ),
                       child: Text('Login')
                       ),
                  );
  }
  Widget createAccount(){
    return TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignUpScreen()
                          ));
                    },
                     child: Text("Create an Account",style: TextStyle(
                      color: Colors.purpleAccent
                     ),),
                     );
  }

  Widget loginOnPhone(){
    return TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInWithPhone() ));
                      },
                       child: Text('Login with Phone Number',
                       style: TextStyle(color: Colors.purple) ,)
                       );
  }
  Widget LoginText(){
    return Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      
                    ),
                  );
  }
}