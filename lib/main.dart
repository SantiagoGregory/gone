import 'package:flutter/material.dart';

import 'package:gone/widgets/homepage.dart';
import 'package:gone/widgets/loadingpage.dart';
import 'package:gone/widgets/constants.dart' as Constants;
import 'package:gone/widgets/loginpage.dart';


void main() => runApp(Gone());

class Gone extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    print('ASDFSADF');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(),
      home: HomePage(null),
    );
  }
}


          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
