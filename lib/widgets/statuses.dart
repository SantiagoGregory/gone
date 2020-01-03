import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'constants.dart' as Constants;

List<String> getSuggestions(pattern, list) {
  List<String> suggestions = [];
  for (final s in list) {
    if (s.startsWith(pattern) && pattern != '') {
      suggestions.add(s);
    }
  }
  return suggestions;
}

class StatusList extends StatelessWidget {
  StatusList(this.friendids);

  final List<String> friendids;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading . . . ",
                style: TextStyle(color: Colors.white));
          }
          return ListView.separated(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              dynamic currentDocument = snapshot.data.documents[index];
              if (friendids.contains(currentDocument.documentID))
                return Status(currentDocument.data["name"],
                    currentDocument.data["status"]);
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.white);
            },
          );
        });
  }
}

class Status extends StatefulWidget {
  const Status(this.name, this.status, {Key key}) : super(key: key);

  final String name;
  final String status;
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  // TODO add dismissable
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: FlutterLogo(size: 50),
          title: Text(widget.name,
              style: TextStyle(color: Colors.white, fontSize: 25)),
          subtitle: Text(widget.status, style: TextStyle(color: Colors.grey)),
          trailing: IconButton(
            icon: Icon((_favorite) ? Icons.favorite : Icons.favorite_border),
            iconSize: 30,
            color: Colors.white,
            splashColor: Colors.black,
            onPressed: () {
              setState(() {
                _favorite = !_favorite;
              });
            },
          ),
        ),
        color: Colors.black);
  }
}
