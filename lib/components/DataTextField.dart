import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ecoins/components/CustomSelectDropDown.dart';
import 'package:ecoins/screens/videoPlayerScreen.dart';

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

  var countryList = [
    "Argentina",
    "Bolivia",
    "Brasil",
    "Chile",
    "Colombia",
    "Costa Rica",
    "Cuba",
    "Ecuador",
    "El Salvador",
    "España",
    "Estados Unidos de América",
    "Guatemala",
    "Honduras",
    "México",
    "Nicaragua",
    "Panamá",
    "Paraguay",
    "Perú",
    "Puerto Rico",
    "República Dominicana",
    "Uruguay",
    "Venezuela",
    "Otro"
  ];

  var genderList = [
    "Masculino",
    "Femenino",
    "Otro",
    "No respondo"
  ];

  var ageList = ["1"];

  var countryValue;
  var genderValue;
  var ageValue;

  void onValueChanged (type, value) {
    if(type == "country") {
      setState(() {
        countryValue = value;
      });
    }
    if(type == "gender") {
      setState(() {
        genderValue = value;
      });
    }
    if(type == "age") {
      setState(() {
        ageValue = value;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _age_controller = TextEditingController();
    _country_controller = TextEditingController();
    _gender_controller = TextEditingController();
    countryValue = null;
    genderValue = null;
    for (int i = 2; i <= 100; i++) {
      ageList.add(i.toString());
    }
    ageValue = null;
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
                        height: constraints.maxHeight*0.043,
                        margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                        // padding: EdgeInsets.fromLTRB(0,0,0,8),
                        child: CustomSelectDropDown(
                          itemList: countryList,
                          dropdownValue: countryValue,
                          onValueChanged: onValueChanged,
                          type: "country",
                          textStyle: TextStyle(
                              color: Colors.blue[700],
                              fontSize: constraints.maxHeight*0.025,
                              fontWeight: FontWeight.bold
                          ),
                          constraints: constraints,
                        ),
                      ),

                      // Container(
                      //   width: constraints.maxWidth*0.25,
                      //   height: constraints.maxHeight*0.04,
                      //   margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                      //   padding: EdgeInsets.fromLTRB(0,0,0,8),
                      //   // color: Colors.green,
                      //   child: TextField(
                      //     style: TextStyle(
                      //         color: Colors.blue[700],
                      //         fontSize: constraints.maxHeight*0.025,
                      //         fontWeight: FontWeight.bold
                      //     ),
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none
                      //     ),
                      //     controller: _country_controller,
                      //     onSubmitted: (String value) async {
                      //       await showDialog<void>(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //             title: const Text('Thanks!'),
                      //             actions: <Widget>[
                      //               TextButton(
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: const Text('OK'),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: constraints.maxHeight*0.04),
                      Container(
                        width: constraints.maxWidth*0.25,
                        height: constraints.maxHeight*0.043,
                        margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                        // padding: EdgeInsets.fromLTRB(0,0,0,8),
                        child: CustomSelectDropDown(
                          itemList: ageList,
                          dropdownValue: ageValue,
                          onValueChanged: onValueChanged,
                          type: "age",
                          textStyle: TextStyle(
                              color: Colors.blue[700],
                              fontSize: constraints.maxHeight*0.025,
                              fontWeight: FontWeight.bold
                          ),
                          constraints: constraints,
                        ),
                      ),
                      // Container(
                      //   width: constraints.maxWidth*0.25,
                      //   height: constraints.maxHeight*0.04,
                      //   margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                      //   padding: EdgeInsets.fromLTRB(0,0,0,8),
                      //   // color: Colors.green,
                      //   child: TextField(
                      //     style: TextStyle(
                      //         color: Colors.blue[700],
                      //         fontSize: constraints.maxHeight*0.025,
                      //         fontWeight: FontWeight.bold
                      //     ),
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none
                      //     ),
                      //     controller: _age_controller,
                      //     onSubmitted: (String value) async {
                      //       await showDialog<void>(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //             title: const Text('Thanks!'),
                      //             actions: <Widget>[
                      //               TextButton(
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: const Text('OK'),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: constraints.maxHeight*0.035),
                      Container(
                        width: constraints.maxWidth*0.25,
                        height: constraints.maxHeight*0.043,
                        margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                        // padding: EdgeInsets.fromLTRB(0,0,0,8),
                        child: CustomSelectDropDown(
                          itemList: genderList,
                          dropdownValue: genderValue,
                          onValueChanged: onValueChanged,
                          type: "gender",
                          textStyle: TextStyle(
                              color: Colors.blue[700],
                              fontSize: constraints.maxHeight*0.025,
                              fontWeight: FontWeight.bold
                          ),
                          constraints: constraints,
                        ),
                      ),
                      // Container(
                      //   width: constraints.maxWidth*0.25,
                      //   height: constraints.maxHeight*0.04,
                      //   margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1, 0, 0, 0),
                      //   padding: EdgeInsets.fromLTRB(0,0,0,8),
                      //   // color: Colors.green,
                      //   child: TextField(
                      //     style: TextStyle(
                      //         color: Colors.blue[700],
                      //         fontSize: constraints.maxHeight*0.025,
                      //         fontWeight: FontWeight.bold
                      //     ),
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none
                      //     ),
                      //     controller: _gender_controller,
                      //     onSubmitted: (String value) async {
                      //       await showDialog<void>(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //             title: const Text('Thanks!'),
                      //             actions: <Widget>[
                      //               TextButton(
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: const Text('OK'),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       );
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: constraints.maxHeight*0.025),
                      InkWell(
                        child: Container(
                          // color: Colors.green,
                          height: constraints.maxHeight*0.075,
                          width: constraints.maxWidth*0.1,
                        ),
                        onTap: () {
                          // widget.game.overlays.remove("EnterData");
                          // Navigator.pushReplacementNamed(this.context, '/video');
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (BuildContext context) => VideoPlayerScreen(),
                          ));
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
