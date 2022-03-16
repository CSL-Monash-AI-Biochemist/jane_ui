import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jane_ui/components/jane_status.dart';

class MsgBox extends StatefulWidget {
  MsgBox({Key? key}) : super(key: key);

  @override
  _MsgBoxState createState() => _MsgBoxState();
}

class _MsgBoxState extends State<MsgBox> {
  @override
  Widget build(BuildContext context) {
    final janeStatus = context.watch<JaneStatus>();

    return Expanded(
      flex: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800, width: 5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          child: ListView(
            children: [
              Text(janeStatus.consoleMsg,
                style: const TextStyle(
                  fontSize: 17
                ),)
            ],
          ),
        ),
      ),
    );
  }
}

