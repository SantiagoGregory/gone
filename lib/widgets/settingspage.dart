import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gone/widgets/loginpage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nice_button/nice_button.dart';
import 'constants.dart' as Constants;

class SettingsPage extends StatelessWidget {
  const SettingsPage(this.auth, this.googleSignIn);

  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  // final String name;
  // final String email;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .5,
          ),
        ),
        // Text(this.name,
        //     style: TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 50)),
        // Text('Logged in as ${this.email}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 30)),
        NiceButton(
          width: MediaQuery.of(context).size.width * .65,
          elevation: 8.0,
          radius: 52.0,
          text: "Logout",
          background: Colors.red,
          onPressed: () async {
            auth.signOut().then((e) => googleSignIn.signOut().then((e) =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()))));
          },
        )
      ],
  ));
  }
}
