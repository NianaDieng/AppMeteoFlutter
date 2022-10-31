import 'package:flutter/material.dart';

Widget currentWeather(IconData icon, String temp, String location) {
  return Center(
    
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Icon(
          icon,
          color: Colors.orange,
          size: 64.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "$temp",
          style: TextStyle(fontSize: 45),
        ),
        SizedBox(
          height: 18.0,
        ),
        Text("$location",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
      ],
    ),
  );
}
