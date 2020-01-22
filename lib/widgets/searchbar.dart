import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/Suggestion.dart';
import 'package:gone/widgets/statuses.dart';
import 'constants.dart' as Constants;



class UserStatus extends StatefulWidget {
  const UserStatus(this.status);
  final String status;
  @override
  _UserStatusState createState() => _UserStatusState(status);
}

class _UserStatusState extends State<UserStatus> {
  _UserStatusState(String _status);
  bool _editing = false;
  String _status;

  final border = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.white, width: 1.5)); // TODO globalize
  final borderGrey = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.5));

  final focus = FocusNode();

  // void changeStatus(String s) {
  //   setState(() {
  //     _status = s;
  //   });
  // }
  void changeStatus(String s) {
    _status = s;
  }

  @override
  Widget build(BuildContext context) {
    // changeStatus(widget.status);
    if (_status == null) {
      _status = widget.status;
    }
    return !_editing
        ? InkWell(
            splashColor: Colors.black,
            onTap: () {
              this.setState(() {
                _editing = true;
              });
              FocusScope.of(context).requestFocus(focus);
            },
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                ), // TODO make more relative
                Text('"$_status"',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)), // TODO make relative
                SizedBox(
                  width: 15,
                ), // TODO make relative
                Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              ],
            ))
        : InkWell(
            splashColor: Colors.black,
            onFocusChange: (bool b) {
              if (!b && _editing) {
                this.setState(() {
                  _editing = false;
                });
              }
            },
            child: TextField(
              focusNode: focus, // TODO auto open keyboard
              // autofocus: true,
              onEditingComplete: () {
                this.setState(() {
                  _editing = false;
                });
              },
              onSubmitted: (String value) {
                Firestore.instance
                    .collection("users")
                    .document(Constants.DUMMY_UID)
                    .updateData({'status': value});

                this.setState(() {
                  _editing = false;
                });
                changeStatus(value);
                print(_status);
              },
              decoration: InputDecoration(
                  enabledBorder: border,
                  border: borderGrey,
                  labelText: _status,
                  labelStyle: TextStyle(color: Colors.grey)),
              style: TextStyle(color: Colors.white, fontSize: Constants.INPUT_FONT_SIZE),
            ));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar(this.name, this.status, this.users);

  final String name;
  final String status;
  final List<dynamic> users;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.5));
    final borderGrey = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .1,
          ),
        ),
        Text(name,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50)),
        FractionallySizedBox(
            widthFactor: .95, child: UserStatus(status)), // TODO globalize .95
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .2,
          ),
        ),

        Flexible(
          child: FractionallySizedBox(
            heightFactor: .2,
          ),
        ),

        FractionallySizedBox(
          widthFactor: .95,
          child: TypeAheadField(
            
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              style: TextStyle(color: Colors.white, fontSize: Constants.INPUT_FONT_SIZE),
              decoration: InputDecoration(
                  enabledBorder: border,
                  border: borderGrey,
                  labelText: 'Search friends',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            suggestionsCallback: (pattern) {
              // dynamic test = Firestore.instance.collection('users').snapshots();
              // List<dynamic> uList;
              // for(String s in users) {
              //   print(s);
              //   uList.add(s);
              // }
              // return getSuggestions(pattern, List.from(users));
              return getSuggestions(pattern, users);
            },
            itemBuilder: (context, suggestion) {
              print(suggestion.runtimeType);
              return Container(
                  color: Colors.black, child: Suggestion(suggestion, false));
            },
            onSuggestionSelected: (suggestion) {
              print('$suggestion selected');
            },
            noItemsFoundBuilder: (BuildContext context) => Container(
                color: Colors.black,
                child: Suggestion('No friends found!', true)),
          ),
        ),

        // errorBuilder: (BuildContext context, Object error) => Text('$error',
        //     style: TextStyle(color: Theme.of(context).errorColor))),
      ],
    );
  }
}
