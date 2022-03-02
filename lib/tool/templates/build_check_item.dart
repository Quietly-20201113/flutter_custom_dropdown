import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';

Widget buildCheckItem(BuildContext context, dynamic data, bool selected, String? valueKey) {
  return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Text(
            defaultGetItemLabel(data, valueKey),
            style: selected
                ? new TextStyle(fontSize: 14.0, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400)
                : new TextStyle(fontSize: 14.0),
          ),
          new Expanded(
              child: new Align(
            alignment: Alignment.centerRight,
            child: selected
                ? new Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
          )),
        ],
      ));
}
