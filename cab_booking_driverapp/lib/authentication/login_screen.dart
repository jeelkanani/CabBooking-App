import 'package:cab_booking_driverapp/SplashScreen/splash_screen.dart';
import 'package:cab_booking_driverapp/authentication/signup_screen.dart';
import 'package:cab_booking_driverapp/global/global.dart';
import 'package:cab_booking_driverapp/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginScreen extends StatefulWidget
{
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen>
{

  TextEditingController emailtextEditingController=TextEditingController();
  TextEditingController passwordtextEditingController=TextEditingController();

  validataForm()
  {
     if(!emailtextEditingController.text.contains("@gmail.com")){
      Fluttertoast.showToast(msg: 'Email is not vaild');
    }
    else if(passwordtextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: 'Password is required.');
    }
    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
  {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Processing, Please Wait...");
        }
    );
    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverkey){
         final snap=driverkey.snapshot;
         if(snap.value!=null){
           currentFirebaseUser = firebaseUser;
           Fluttertoast.showToast(msg: "Login Successful");
           Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
         }
         else{
           Fluttertoast.showToast(msg: "no record exist with this email.");
           fAuth.signOut();
           Navigator.push(context, MaterialPageRoute(builder: (c)=> const  MySplashScreen() ));
         }

      });

      // Map driverMap =
      // {
      //   "id": firebaseUser.uid,
      //   "email": emailtextEditingController.text.trim(),
      //   "password": passwordtextEditingController.text.trim(),
      // };
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Ocuured during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/signup.png',width: 100.0,height: 100.0,),
              ),

              SizedBox(
                height: 10.0,
              ),

              const Text(
                'Login as a Driver',
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
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
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                child:const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                "Do not have an Account? Signup Here",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>SignUpScreen()));
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
