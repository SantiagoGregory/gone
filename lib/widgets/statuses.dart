import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'constants.dart' as Constants;

List<String> getSuggestions(pattern, list) {
  List<String> suggestions = [];
  for (final s in list) {
    print('HERE $s');
    if (s != null && s.startsWith(pattern) && pattern != '') {
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
              // if (friendids.contains(currentDocument.documentID))
              return Status(currentDocument.data["name"],
                  currentDocument.data["status"], currentDocument.documentID);
            },
            separatorBuilder: (context, index) {
              return Divider(color: Colors.white);
            },
          );
        });
  }
}

class Status extends StatefulWidget {
  const Status(this.name, this.status, this.uid, {Key key}) : super(key: key);

  final String name;
  final String status;
  final String uid;
  @override
  _StatusState createState() => _StatusState(status);
}

class _StatusState extends State<Status> {
  _StatusState(this._status);
  String _status; // TODO final?
  // TODO add dismissable
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: FlutterLogo(size: 30),
            // title: Text(widget.name,
            //     style: TextStyle(color: Colors.white, fontSize: 25)),
            title: RichText(
                text: TextSpan(
                    text: widget.name, // TODO make relative
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    children: <TextSpan>[
                  TextSpan(
                      text: '\n"${widget.status}"', // TODO make better
                      style: TextStyle(color: Colors.grey, fontSize: 25, fontStyle: FontStyle.italic)),
                ])),
            subtitle: Text(widget.uid, style: TextStyle(color: Colors.grey)),
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
            )),
        color: Colors.black);
  }
}
