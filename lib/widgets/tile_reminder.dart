import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileReminder extends StatelessWidget{

  List<MaterialColor> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.cyan,
    Colors.brown,
    Colors.grey
  ];

  TileReminder({super.key});

  MaterialColor getRandomColor(){
    return colors[Random().nextInt(11)];
  }

  bool _isBellRinging = true;

  void onTap(){
    Alarm.stop(42);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0, // Set the width of the box
      height: 150.0, // Set the height of the box
      padding: EdgeInsets.all(16.0), // Optional: Add padding inside the box
      decoration: BoxDecoration(
        color: getRandomColor(), // Set the background color of the box

        borderRadius: BorderRadius.circular(8.0), // Optional: Add rounded corners
      ),
      child: GestureDetector(
        onTap: onTap,
        child:  Center(
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   _isBellRinging = !_isBellRinging;
                    // });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isBellRinging ? Colors.yellow : Colors.grey,
                    ),
                    child: Icon(
                      Icons.notifications,
                      size: 20,
                      color: _isBellRinging ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              Text(
                'Send email to Anita',
                style: TextStyle(
                  color: Colors.black, // Set the text color
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold// Set the text font size
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Text(
                  'Send email regarding vouchers to employee. This is just sample description to show the '
                      'use of this app.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.black, // Set the text color
                    fontSize: 16.0, // Set the text font size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}