import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Suggestion extends StatelessWidget {
  const Suggestion(this.name, this.textOnly, [this.subText, this.icon]);

  final String name;
  final bool textOnly;
  final String subText;
  final Icon icon;

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
                subtitle: Text(this.subText ?? '',
                    style: TextStyle(color: Colors.grey)),
                trailing: this.icon ?? null,
              ),
        color: Colors.black);
  }
}
