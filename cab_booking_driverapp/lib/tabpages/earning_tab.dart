import 'package:flutter/material.dart';
class EarningsTabpage extends StatefulWidget {
  const EarningsTabpage({Key? key}) : super(key: key);

  @override
  _EarningsTabpageState createState() => _EarningsTabpageState();
}

class _EarningsTabpageState extends State<EarningsTabpage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Earning',
      ),
    );
  }
}
