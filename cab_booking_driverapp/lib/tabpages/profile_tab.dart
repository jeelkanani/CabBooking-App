import 'package:cab_booking_driverapp/SplashScreen/splash_screen.dart';
import 'package:cab_booking_driverapp/global/global.dart';
import 'package:flutter/material.dart';
class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text(
          "sign Out",
        ),
        onPressed: ()
        {
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        },
      ),
    );
  }
}
