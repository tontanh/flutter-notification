import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_alert/alert.dart';

import 'package:http/http.dart' as http;
class ScreenPage extends StatefulWidget {
  const ScreenPage({Key? key}) : super(key: key);

  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('owlmall'),
        centerTitle: true,
      ),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.blue),
        child: InkWell(
          onTap: (){
           
            getData();
          },
            child: Center(
          child: Text("Alert"),
        )),
      ),
    );
  }
 
}
