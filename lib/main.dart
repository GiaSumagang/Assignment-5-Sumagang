import 'package:assignment5/homepage.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.lime
    ),
    title: 'MyApp',
    home: const HomePage(),
  ));
}