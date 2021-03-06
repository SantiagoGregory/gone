import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/findpage.dart';
import 'package:gone/widgets/loadingpage.dart';
import 'package:gone/widgets/searchbar.dart';
import 'package:gone/widgets/settingspage.dart';
import 'package:gone/widgets/statuses.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'constants.dart' as Constants;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/loadingpage.dart';
import 'package:gone/widgets/searchbar.dart';
import 'package:gone/widgets/settingspage.dart';
import 'package:gone/widgets/statuses.dart';
import 'constants.dart' as Constants;

class HomePage extends StatefulWidget {
  HomePage(this.auth, this.googleSignIn, this.displayName, this.email, {Key key}) : super(key: key);

  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final String displayName;
  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  Widget getScreen(int index, dynamic data) {
    switch (index) {
      case 0:
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                250), // TODO add relative height wait maybe it is
            child: SearchBar(data['name'], data['status'],
                new List<String>.from(data["friends"])), // TODO snapshot
          ),
          body: StatusList(new List<String>.from(data["friends"])),
          // getScreen(_index, snapshot.data),

          backgroundColor: Constants.BG_COLOR,
        );
        break;
      case 1:
        return LoadingPage(); // TODO change, placeholder
      case 2:
        return SettingsPage(widget.auth, widget.googleSignIn);
    }
  }

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
    print(index);
  }

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
            body: getScreen(_index, snapshot.data),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    activeIcon:
                        Icon(Icons.home, color: Constants.COMPONENT_COLOR),
                    icon: Icon(
                      Icons.home,
                      color: Constants.DESELECT_COLOR,
                    ),
                    title: Text('')),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.person_add,
                        color: Constants.COMPONENT_COLOR),
                    icon:
                        Icon(Icons.person_add, color: Constants.DESELECT_COLOR),
                    title: Text('')),
                BottomNavigationBarItem(
                    activeIcon:
                        Icon(Icons.settings, color: Constants.COMPONENT_COLOR),
                    icon: Icon(Icons.settings, color: Constants.DESELECT_COLOR),
                    title: Text('')),
              ],
              currentIndex: 0,
              selectedItemColor: Colors.blue,
              onTap: _onTap,
              backgroundColor: Constants.BG_COLOR,
            ),
            backgroundColor: Constants.BG_COLOR,
          );
        });
  }
}

class HomePage1 extends StatefulWidget {
  HomePage1(this.auth, this.googleSignIn, this.displayName, this.email,
      {Key key})
      : super(key: key);

  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final String displayName;
  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState1 extends State<HomePage1> {
  int _index = 0;

  Widget getScreen(int index, dynamic data) {
    switch (index) {
      case 0:
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                250), // TODO add relative height wait maybe it is
            child: SearchBar(widget.displayName, data['status'],
                new List<String>.from(data["friends"])), // TODO snapshot
          ),
          body: StatusList(new List<String>.from(data["friends"])),
          // getScreen(_index, snapshot.data),

          backgroundColor: Constants.BG_COLOR,
        );
        break;
      case 1:
        // return SearchBar(data['name'], data['status'],
        //         new List<String>.from(data["friends"]));
        return FindPage(
            new List<String>.from(data['friends'])); // TODO change, placeholder
      case 2:
        return SettingsPage(widget.auth, widget.googleSignIn);
    }
  }

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance
            .collection('users')
            .document(Constants.DUMMY_UID)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return LoadingPage();
          }
          return Scaffold(
            body: getScreen(_index, snapshot.data),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    activeIcon:
                        Icon(Icons.home, color: Constants.COMPONENT_COLOR),
                    icon: Icon(
                      Icons.home,
                      color: Constants.DESELECT_COLOR,
                    ),
                    title: Text('')),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.person_add,
                        color: Constants.COMPONENT_COLOR),
                    icon:
                        Icon(Icons.person_add, color: Constants.DESELECT_COLOR),
                    title: Text('')),
                BottomNavigationBarItem(
                    activeIcon:
                        Icon(Icons.settings, color: Constants.COMPONENT_COLOR),
                    icon: Icon(Icons.settings, color: Constants.DESELECT_COLOR),
                    title: Text('')),
              ],
              currentIndex: _index,
              selectedItemColor: Colors.blue,
              onTap: _onTap,
              backgroundColor: Constants.BG_COLOR,
            ),
            backgroundColor: Constants.BG_COLOR,
          );
        });
  }
}
