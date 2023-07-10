import 'package:flutter/material.dart';
import 'package:ecoins/components/CustomSelectDropDown.dart';
import 'package:ecoins/screens/videoPlayerScreen.dart';
import 'dart:convert';
import 'api.dart';

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
  bool isError = false;
  var _errorMessage = "Por favor seleccione todos los valores";
  bool isLoading = false;

  _register(age, country, gender) async {
    if(age == null || country == null || gender == null){
      setState(() {
        isError = true;
        _errorMessage = "";
      });
    }
    else {
      setState(() {
        isLoading = true;
      });
      var response = await CallApi().postDataStart(
          age, country, gender, 'datos_jugador');
      var body = json.decode(response.body);
      if(response.statusCode == 200 && int.parse(body["codigo"]) == 00) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(
          builder: (BuildContext context) =>
              VideoPlayerScreen(),
        ));
      }
      else {
        setState(() {
          isLoading = false;
          isError = true;
          _errorMessage = "¡Error Interno del Servidor! Inténtalo de nuevo";
        });
      }
    }
  }

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
    setState(() {
      isError = false;
      _errorMessage = "";
    });
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
                      isError ?
                      Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: constraints.maxHeight*0.02, fontWeight: FontWeight.bold),)
                          :
                      SizedBox(height: constraints.maxHeight*0.025),
                      isLoading ?
                      CircularProgressIndicator()
                          :
                      InkWell(
                        child: Container(
                          // color: Colors.green,
                          height: constraints.maxHeight*0.075,
                          width: constraints.maxWidth*0.1,
                        ),
                        onTap: () {
                          // widget.game.overlays.remove("EnterData");
                          // Navigator.pushReplacementNamed(this.context, '/video');
                          _register(ageValue, countryValue, genderValue);

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
