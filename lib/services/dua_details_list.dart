import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dua_demo/models/dua_detail_model.dart';
import 'package:flutter/material.dart';

class DuaDetailList extends StatefulWidget {
  DuaDetailList({Key key, @required this.duaId, this.firestore})
      : super(key: key);

  final int duaId;
  final firestore;

  @override
  _DuaDetailListState createState() => new _DuaDetailListState();
}

class _DuaDetailListState extends State<DuaDetailList> {
  Color _appColor = new Color(0xFF00B17C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //print(widget.duaId);
          },
        ),
      ),
      body: Container(
        child: duaList(context),
      ),
    );
  }

  Widget duaList(BuildContext context) {
    int index = 0;
    Future<List<DuaDetail>> duaDetailList = getData();
    return StreamBuilder(
      stream: widget.firestore
          .collection('dua_details')
          .where('dua_id', isEqualTo: widget.duaId)
          .orderBy('line_no')
          .snapshots(),
      builder: (context, snapshot) {
        return ListView.separated(
          itemCount: (snapshot?.data?.documents?.length ?? 0),
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  //QuerySnapshot querySnapshot = snapshot.data;
                  //print(querySnapshot.documents[1].data);
                  //getData();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      snapshot.data.documents[index].data['arabic_translation']
                          .toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Cairo',
                        letterSpacing: 2.0,
                        wordSpacing: 2.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    new Text(
                      snapshot.data.documents[index].data['pronounciation']
                          .toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        letterSpacing: 1.0,
                        wordSpacing: 1.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    new Text(
                      snapshot.data.documents[index].data['eng_translation']
                          .toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        letterSpacing: 2.0,
                        wordSpacing: 2.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<List<DuaDetail>> getData() async {
    final QuerySnapshot result = await widget.firestore
        .collection('dua_details')
        .where('dua_id', isEqualTo: widget.duaId)
        .getDocuments();

    List<DuaDetail> duaDetailsList = [];

    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length != 0) {
      documents.forEach(
        (document) => {
          duaDetailsList.add(DuaDetail(
              duaDetailId: document['dua_detail_id'],
              duaId: document['dua_id'],
              lineNo: document['line_no'],
              arabicTranslation: document['arabic_translation'],
              englishTranslation: document['eng_translation'],
              urduTranslation: document['urdu_translation'],
              pronounciation: document['pronounciation']))
        },
      );
      print(duaDetailsList);
      return duaDetailsList;
    }
  }
}
