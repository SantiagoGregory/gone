import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/loadingpage.dart';
import 'package:gone/widgets/searchbar.dart';
import 'package:gone/widgets/statuses.dart';
import 'constants.dart' as Constants;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance
            .collection('users')
            .document(Constants.DUMMY_UID)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingPage();
          }
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  300), // TODO add relative height wait maybe it is
              child: SearchBar(snapshot.data['name'],
                  snapshot.data['status']), // TODO snapshot
            ),
            // body: Text('placeholder', style: TextStyle(color: Colors.white)),

            body: StatusList(new List<String>.from(snapshot.data["friends"])),
            backgroundColor: Constants.BG_COLOR,
          );
        });
  }
}
