import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/Suggestion.dart';
import 'package:gone/widgets/statuses.dart';
import 'package:nice_button/nice_button.dart';
import 'constants.dart' as Constants;

class FindPage extends StatelessWidget {
  const FindPage(this.friends);

  final List<dynamic> friends;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.5));
    final borderGrey = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5));
    return Center(
        child: Column(
      children: <Widget>[
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .1,
          ),
        ),
        FractionallySizedBox(
          widthFactor: .95,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: false,
              style: TextStyle(
                  color: Colors.white, fontSize: Constants.INPUT_FONT_SIZE),
              decoration: InputDecoration(
                  enabledBorder: border,
                  border: borderGrey,
                  labelText: 'Search users',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, friends);
            },
            itemBuilder: (context, suggestion) {
              return Container(
                  color: Colors.black,
                  child: Suggestion(
                      suggestion,
                      false,
                      this.friends.contains(suggestion)
                          ? 'This user is already in your friends list!'
                          : null,
                      Icon(Icons.person_add, color: Colors.grey,)));
            },
            onSuggestionSelected: (suggestion) {
              print('$suggestion selected');
            },
            noItemsFoundBuilder: (BuildContext context) => Container(
                color: Colors.black,
                child: Suggestion('No users found!', true)),
          ),
        ),
      ],
    ));
  }
}
