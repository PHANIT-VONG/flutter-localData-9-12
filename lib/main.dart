import 'package:flutter/material.dart';
import 'package:flutter_local_data/pages/show_people.dart';
import 'package:flutter_local_data/pages/test_share_pre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const TestSharePre(),
      home: const ShowPeople(),
    );
  }
}
