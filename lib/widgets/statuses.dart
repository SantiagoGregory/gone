import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'constants.dart' as Constants;
import 'fetch.dart';


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
  StatusList(this.friends);

  final List<Map> friends;

  @override
  Widget build(BuildContext context) {
    print('over here');
    return ListView.separated(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return Status(friends[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(color: Colors.white);
      },
    );
    // return FloatingSearchBar.builder(
    //   itemCount: friends.length,
    //   itemBuilder: (context, i) {
    //     return Status(friends[i]);
    //   },
    // );
  }
}

class Status extends StatefulWidget {
  const Status(this.data, {Key key}) : super(key: key);

  final Map data;
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
          title: Text(widget.data.keys.first,
              style: TextStyle(color: Colors.white, fontSize: 25)),
          subtitle: Text(widget.data.values.first, style: TextStyle(color: Colors.grey)),
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

