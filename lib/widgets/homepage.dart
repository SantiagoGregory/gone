import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gone/widgets/fetch.dart';
import 'package:gone/widgets/searchbar.dart';
import 'package:gone/widgets/statuses.dart';
import 'constants.dart' as Constants;

class HomePage extends StatefulWidget {
  HomePage(this.data, {Key key}) : super(key: key);

  final Map data;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getFriendData() async {
    List friendFetch;
    dynamic test = await fetchUserData(widget.data['friends'][0]);
    friendFetch.add(test);
    return friendFetch;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getFriendData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('TODO loading list but keep searchbar');
              break;
            case ConnectionState.done:
              print('DONE in homepage.dart');
              List<Map> test = new List<Map>();
              test.add({"Testing User": "Busy"});
              test.add({"Testing User 2": "Also busy"});
              print('TEST');
              print(test.length);
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      300), // TODO add relative height wait maybe it is
                  child: SearchBar(widget.data, test), // TODO snapshot
                ),
                body: StatusList(test),
                backgroundColor: Constants.BG_COLOR,
              );
              break;
            default:
              return Text('hi');
          }
        });
  }
}
