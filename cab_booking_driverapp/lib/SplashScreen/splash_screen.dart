import 'dart:async';
import 'package:cab_booking_driverapp/authentication/login_screen.dart';
import 'package:cab_booking_driverapp/authentication/signup_screen.dart';
import 'package:cab_booking_driverapp/mainscreens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_driverapp/global/global.dart';
class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer( const Duration(seconds: 5), () async {
      if(await fAuth.currentUser != null){
        //send user to home screen
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MainScreen()));
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
      }

    });
  }
  
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        color: Colors.black87,

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/signup.png",width: 200,height: 200),
              const SizedBox(
                 height: 40.0,
              ),
              const Text(
                "Driver App",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
