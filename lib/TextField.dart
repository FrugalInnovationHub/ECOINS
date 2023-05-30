import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [TextField].

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample>{
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
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: MediaQuery.of(context).size.width / 30,
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.60, 0, 0, MediaQuery.of(context).size.height*0.09),
      padding: EdgeInsets.all(4),
            child: TextField(
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
          ),
          TextButton(
            onPressed: () {
              print('I got clicked');
            },
            child: Image.asset('images/enter_button.png'),
          ),
        ],
      ),
    );
  }
}
