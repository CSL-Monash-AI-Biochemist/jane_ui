import 'dart:html';

import 'package:flutter/material.dart';

class msgBox extends StatefulWidget {
  final String value;
  
  msgBox({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _msgBoxState createState() => _msgBoxState();
}

class _msgBoxState extends State<msgBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade800,
            width: 5
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          child: ListView(
            children: [
              Text('hi'),
              Text('2'),
              Text('2'),
              Text('hi'),
              Text('2'),
              Text('2'),
              Text('hi'),
              Text('2'),
              Text('2'),
              Text('hi'),
              Text('2'),
              Text('2'),
            ],
          ),
        ),
      ),
    );
  }
}