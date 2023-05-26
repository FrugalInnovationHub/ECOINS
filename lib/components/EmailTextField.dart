import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';



class EmailTextField extends StatefulWidget {
  const EmailTextField({super.key});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField>{
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: Container(
        width: MediaQuery.of(context).size.width*0.25,
        height: MediaQuery.of(context).size.height*0.04,
        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.60, 0, 0, MediaQuery.of(context).size.height*0.09),
        padding: EdgeInsets.all(4),
        // color: Colors.green,
        child: TextField(
          style: TextStyle(
            color: Colors.blue[700],
            fontSize: min(MediaQuery.of(context).size.height*0.03,24),
            fontWeight: FontWeight.bold
          ),
          decoration: InputDecoration(
            border: InputBorder.none
          ),
          controller: _controller,
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thanks!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      )
      ),
    );
  }
}
