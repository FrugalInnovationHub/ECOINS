import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class DataTextField extends StatefulWidget {
  final game;
  const DataTextField({Key? key, this.game}) : super(key: key);

  @override
  State<DataTextField> createState() => _DataTextFieldState();
}

class _DataTextFieldState extends State<DataTextField> {
  late TextEditingController _age_controller;
  late TextEditingController _country_controller;
  late TextEditingController _gender_controller;

  @override
  void initState() {
    super.initState();
    _age_controller = TextEditingController();
    _country_controller = TextEditingController();
    _gender_controller = TextEditingController();
  }

  @override
  void dispose() {
    _age_controller.dispose();
    _country_controller.dispose();
    _gender_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            child: new LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
              return Center(
                child: Container(
                  height: constraints.maxHeight*0.4,
                  width: constraints.maxWidth*0.45,
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight*0.05),
                      Container(
                        width: constraints.maxWidth*0.25,
                        height: constraints.maxHeight*0.04,
                        margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(0,0,0,8),
                        // color: Colors.green,
                        child: TextField(
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: constraints.maxHeight*0.025,
                              fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          controller: _country_controller,
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
                      SizedBox(height: constraints.maxHeight*0.04),
                      Container(
                        width: constraints.maxWidth*0.25,
                        height: constraints.maxHeight*0.04,
                        margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(0,0,0,8),
                        // color: Colors.green,
                        child: TextField(
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: constraints.maxHeight*0.025,
                              fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          controller: _age_controller,
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
                      SizedBox(height: constraints.maxHeight*0.04),
                      Container(
                        width: constraints.maxWidth*0.25,
                        height: constraints.maxHeight*0.04,
                        margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(0,0,0,8),
                        // color: Colors.green,
                        child: TextField(
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: constraints.maxHeight*0.025,
                              fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                          controller: _gender_controller,
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
                      SizedBox(height: constraints.maxHeight*0.025),
                      InkWell(
                        child: Container(
                          // color: Colors.green,
                          height: constraints.maxHeight*0.075,
                          width: constraints.maxWidth*0.1,
                        ),
                        onTap: () {
                          // widget.game.overlays.remove("EnterData");
                          Navigator.pushReplacementNamed(this.context, '/video');
                        },
                      ),
                    ],
                  ),
                )
              );
            }),
          ),
        ),
      )
    );
  }
}
