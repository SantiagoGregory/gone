import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart' as Constants;

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.running,
              size: 200.0,
              color: Colors.white,
            ),
            SizedBox(height: 50),
            SpinKitThreeBounce(color: Colors.white, size: 50),
          ],
        ),
      ),
      backgroundColor: Constants.BG_COLOR,
    );
  }
}