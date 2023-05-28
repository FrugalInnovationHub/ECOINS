import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [TextField].

class TextFieldExampleApp extends StatelessWidget{
  const TextFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TextFieldExample(),
    );
  }
}

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
          SizedBox(height:1, width: 1,), // Add some spacing between the TextField and FlatButton
          InkWell(
            onTap: () {}, // Image tapped
            splashColor: Colors.white10, // Splash color over image
            child: Ink.image(
              fit: BoxFit.fill, // Fixes border issues
              width: 120,
              height: 50,
              image: AssetImage(
                  'images/enter_button.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
