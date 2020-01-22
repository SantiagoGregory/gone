import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:gone/widgets/homepage.dart';
import 'package:gone/widgets/settingspage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nice_button/nice_button.dart';
import 'constants.dart' as Constants;

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print('signed in ${user.displayName}');
    return user;
  }

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
        // SignInButton(Buttons.Google, text: "Sign up with Google", onPressed: _handleSignIn()),
        NiceButton(
          width: MediaQuery.of(context).size.width * .65,
          elevation: 8.0,
          radius: 52.0,
          text: "Log in with Google",
          background: Colors.blue,
          onPressed: () {
            _handleSignIn().then((FirebaseUser user) => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(_auth, _googleSignIn, user.displayName, user.email)))
                // HomePage(_auth, _googleSignIn, user.displayName, user.email)
                );
          },
        ),
      ],
    ));
  }
}
// class LoginPage extends StatefulWidget {
//   const LoginPage();

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   _LoginPageState();

//   bool _b = true;
//   dynamic _user;
//   @override
//   Widget build(BuildContext context) {
//     final GoogleSignIn _googleSignIn = GoogleSignIn();
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     Future<FirebaseUser> _handleSignIn() async {
//       final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final FirebaseUser user =
//           (await _auth.signInWithCredential(credential)).user;
//       print('signed in ${user.displayName}');
//       return user;
//     }

//     @override
//     Widget build(BuildContext context) {
//       print('AQUIIIIIIIII');
//       return _b
//           ? Center(
//               child: Column(
//               children: <Widget>[
//                 Flexible(
//                   child: FractionallySizedBox(
//                     heightFactor: .5,
//                   ),
//                 ),
//                 // SignInButton(Buttons.Google, text: "Sign up with Google", onPressed: _handleSignIn()),
//                 NiceButton(
//                   width: MediaQuery.of(context).size.width * .65,
//                   elevation: 8.0,
//                   radius: 52.0,
//                   text: "Log in with Google",
//                   background: Colors.blue,
//                   onPressed: () {
//                     _handleSignIn()
//                         .then((FirebaseUser user) => this.setState(() {
//                               _b = false;
//                               _user = user;
//                             }));

//                     // this.setState(() { _b = false; _user = user});
//                   },
//                 ),
//               ],
//             ))
//           : HomePage(_user);
//     }
//   }
// }
