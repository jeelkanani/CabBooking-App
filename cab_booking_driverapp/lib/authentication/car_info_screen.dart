import 'package:cab_booking_driverapp/SplashScreen/splash_screen.dart';
import 'package:cab_booking_driverapp/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController carModeltextEditingController=TextEditingController();
  TextEditingController CarNumbertextEditingController=TextEditingController();
  TextEditingController carColortextEditingController=TextEditingController();

  List<String> carTypeList =["uber-x","uber-go","bike"];
  String? selectedcarType;

  saveCarInfo()
  {
    Map driverCarInfoMap =
    {
      "car_color": carColortextEditingController.text.trim(),
      "car_number": CarNumbertextEditingController.text.trim(),
      "car_model": carModeltextEditingController.text.trim(),
      "type": selectedcarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
    
    Fluttertoast.showToast(msg: "Car Details has been saved. Congratulation.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [

              const SizedBox(height: 24.0,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/signup.png',width: 100.0,height: 100.0,),
              ),

              SizedBox(
                height: 10.0,
              ),

              const Text(
                ' Write Car Details',
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: carModeltextEditingController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration:const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car Model",
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
                controller: CarNumbertextEditingController,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration:const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car Number",
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
                controller: carColortextEditingController,
                // keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.grey,
                ),
                decoration:const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car Color",
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

              const SizedBox(height: 20,),

              DropdownButton(
                iconSize: 26,
                // icon:Icon(Icons.zoom_out_map),
                dropdownColor: Colors.black,
                hint:  const Text(
                  "Please choose car type",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                value: selectedcarType,
                onChanged: (newvalue){
                  setState(() {
                    selectedcarType=newvalue.toString();
                  });
                },
                items: carTypeList.map((car){
                 return DropdownMenuItem(
                   child: Text(
                     car,
                     style: const TextStyle(color: Colors.grey),
                   ),
                   value: car,
                 );
                }).toList(),
              ),

              const SizedBox(
                height: 10.0,
              ),

              ElevatedButton(
                onPressed: (){
                  if(carColortextEditingController.text.isNotEmpty
                      && CarNumbertextEditingController.text.isNotEmpty
                      && carModeltextEditingController.text.isNotEmpty && selectedcarType != null)
                  {
                    saveCarInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                child:const Text(
                  'Save Now',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              )


            ],
          ),
        )
      ),
    );
  }
}
