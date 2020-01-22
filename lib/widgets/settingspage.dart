import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'constants.dart' as Constants;

class SettingsPage extends StatelessWidget {
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
        Text(Constants.DUMMY_UID,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50)),
        NiceButton(
          width: MediaQuery.of(context).size.width * .65,
          elevation: 8.0,
          radius: 52.0,
          text: "Logout",
          background: Colors.red,
          onPressed: () {
            print("clicked");
          },
        )
      ],
    ));
  }
}
