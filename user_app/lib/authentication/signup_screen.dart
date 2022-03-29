

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/SplashScreen/splash_screen.dart';
import 'package:user_app/authentication/login_screen.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/widgets/progress_dialog.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nametextEditingController=TextEditingController();
  TextEditingController emailtextEditingController=TextEditingController();
  TextEditingController phonetextEditingController=TextEditingController();
  TextEditingController passwordtextEditingController=TextEditingController();



  validataForm()
  {
    if(nametextEditingController.text.length < 3){
         Fluttertoast.showToast(msg: 'name must be atleast 3 characters');
    }
    else if(!emailtextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: 'Email is not vaild');
    }
    else if(phonetextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: 'Phone number is requried');
    }
    else if(passwordtextEditingController.text.length < 6){
      Fluttertoast.showToast(msg: 'Password must be atleast 6 characters');
    }

    else
    {
     saveUserInfoNow();
    }
  }

  saveUserInfoNow() async
  {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Processing Please Wait...");
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
            email: emailtextEditingController.text.trim(),
            password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
        ).user;

    if(firebaseUser != null)
    {
      Map userMap =
          {
            "id": firebaseUser.uid,
            "name": nametextEditingController.text.trim(),
            "email": emailtextEditingController.text.trim(),
            "phone": phonetextEditingController.text.trim(),
            "password": passwordtextEditingController.text.trim(),
          };

     DatabaseReference reference = FirebaseDatabase.instance.ref().child("Users");
     reference.child(firebaseUser.uid).set(userMap);

     currentFirebaseUser = firebaseUser;
     Fluttertoast.showToast(msg: "Account has been Created.");
     Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));

    }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account has not been Created.");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                SizedBox(
                  height: 10.0,
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('images/signup.png',width: 100.0,height: 100.0,),
                ),

                SizedBox(
                  height: 10.0,
                ),

                const Text(
                  'Register as a User',
                  style: const TextStyle(
                    fontSize: 26,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextField(
                  controller: nametextEditingController,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration:const InputDecoration(
                    labelText: "Name",
                    hintText: "Name",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )
                    ),

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),

                  ),
                ),

                TextField(
                  controller: emailtextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration:const InputDecoration(
                    labelText: "Email",
                    hintText: "Email",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),

                  ),
                ),

                TextField(
                  controller: phonetextEditingController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration:const InputDecoration(
                    labelText: "Phone No.",
                    hintText: "Phone Number",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),

                  ),
                ),

                TextField(
                  controller: passwordtextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration:const InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),

                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),

                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),

                ElevatedButton(
                  onPressed: (){
                    validataForm();
                     // Navigator.push(context, MaterialPageRoute(builder: (c)=>CarInfoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                  ),
                  child:const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),

                TextButton(
                  child: const Text(
                    "Already have an Account? Login Here",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                  },

                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
