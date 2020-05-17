import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'screens/dua_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final firebaseReference = Firestore.instance;

  Color _appColor = new Color(0xFF00B17C);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _appColor,
          title: Text('All Dua\'s'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          child: new Container(
            child: DuaList(
              firestore: firebaseReference,
            ),
          ),
        ),
      ),
    );
  }

  void getData() {
    firebaseReference
        .collection("duas")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }
}
