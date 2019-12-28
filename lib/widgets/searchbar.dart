import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/statuses.dart';
import 'constants.dart' as Constants;

class Suggestion extends StatelessWidget {
  const Suggestion(this.name, {this.textOnly});

  final String name;
  final bool textOnly;

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(color: Colors.white, fontSize: 20);
    return Card(
        shape: RoundedRectangleBorder(
            side: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: textOnly
            ? ListTile(title: Text(name, style: ts))
            : ListTile(
                title: Text(name, style: ts),
                leading: FlutterLogo(size: 35),
                subtitle: Text('Status', style: TextStyle(color: Colors.grey)),
              ),
        color: Colors.black);
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar(this.data, this.friends);

  final Map data;
  final List friends;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.5));
    final borderGrey = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5));
    final String name = data['name'];


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
        Flexible(
          child: FractionallySizedBox(
            heightFactor: .2,
          ),
        ),
        FractionallySizedBox(
          widthFactor: .8,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  enabledBorder: border,
                  border: borderGrey,
                  labelText: 'Set a status',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            suggestionsCallback: (pattern) {
              return null;
            },
            itemBuilder: (context, suggestion) {
              return Container(
                  color: Colors.black, child: Suggestion(suggestion));
            },
            onSuggestionSelected: (suggestion) {
              print(suggestion);
            },
            noItemsFoundBuilder: (BuildContext context) => Container(
                color: Colors.black, child: Suggestion('No friends found!')),
          ),
        ),

        Flexible(
          child: FractionallySizedBox(
            heightFactor: .2,
          ),
        ),

        FractionallySizedBox(
          widthFactor: .8,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  enabledBorder: border,
                  border: borderGrey,
                  labelText: 'Search friends',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            suggestionsCallback: (pattern) {
              return getSuggestions(pattern, friends);
            },
            itemBuilder: (context, suggestion) {
              return Container(
                  color: Colors.black, child: Suggestion(suggestion));
            },
            onSuggestionSelected: (suggestion) {
              print(suggestion);
            },
            noItemsFoundBuilder: (BuildContext context) => Container(
                color: Colors.black, child: Suggestion('No friends found!')),
          ),
        ),

        // errorBuilder: (BuildContext context, Object error) => Text('$error',
        //     style: TextStyle(color: Theme.of(context).errorColor))),
      ],
    );
  }
}
