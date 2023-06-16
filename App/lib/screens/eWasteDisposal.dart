import 'package:flutter/material.dart';

class EwasteDisposal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('E-Waste Disposal Sites'),
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('E-Waste Disposal Sites',
              style: TextStyle(
                fontFamily: "marcellus",
                fontSize: 18,
              )),
          SizedBox(width: 8),
          Image(
              image: AssetImage('images/logo.png'),
              height:50),
        ],
      ),
      ),
      body: Center(
        // child: Text('This is the e waste screen'),
        child: Text('This is the e waste screen',
            style: TextStyle(
              fontFamily: "marcellus",
              fontSize: 18,
            )),
      ),
    );
  }
}