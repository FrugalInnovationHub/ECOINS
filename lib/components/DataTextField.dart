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
      body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.04,
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1, 0, 0, 0),
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
                      SizedBox(height: MediaQuery.of(context).size.height*0.04),
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.04,
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1, 0, 0, 0),
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
                      SizedBox(height: MediaQuery.of(context).size.height*0.04),
                      Container(
                        width: MediaQuery.of(context).size.width*0.25,
                        height: MediaQuery.of(context).size.height*0.04,
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1, 0, 0, 0),
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
                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      InkWell(
                          child: Container(
                            // color: Colors.green,
                            height: MediaQuery.of(context).size.height*0.075,
                            width: MediaQuery.of(context).size.width*0.1,
                          ),
                        onTap: () {
                            // widget.game.overlays.remove("EnterData");
                          Navigator.pushReplacementNamed(this.context, '/video');
                        },
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
