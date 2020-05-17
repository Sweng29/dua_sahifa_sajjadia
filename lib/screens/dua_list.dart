import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dua_demo/services/dua_details_list.dart';
import 'package:flutter/material.dart';

class DuaList extends StatelessWidget {
  DuaList({this.firestore});

  final firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection("duas").orderBy("dua_id").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data.documents.length;
        return ListView.builder(
          itemCount: messageCount,
          itemBuilder: (context, index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            final dynamic description = document['description'];
            final dynamic title = document['title'];
            final dynamic duaId = document['dua_id'];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DuaDetailList(
                      duaId: duaId,
                      firestore: firestore,
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: ListTile(
                  leading: Text(duaId.toString()),
                  title: Text(title != null
                      ? title.toString()
                      : '<No message retrieved>'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
