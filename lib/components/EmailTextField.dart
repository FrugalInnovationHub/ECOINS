import 'package:flutter/material.dart';
import '../game.dart';
import 'api.dart';
import 'dart:convert';


class EmailTextField extends StatefulWidget {
  final game;
  const EmailTextField({super.key, this.game});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField>{
  late TextEditingController _controller;
  int ecoins = EcoinsGame.finalEcoins;
  var _errorMessage = "";
  bool isError = false;
  bool isLoading = false;

  bool validateEmail(String val) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Por favor agregar correo electrónico";
      });
      return false;
    }else if(!regExp.hasMatch(val)){
      setState(() {
        _errorMessage = "Dirección de correo electrónico no válido";
      });
      return false;
    }else{
      setState(() {
        _errorMessage = "";
      });
      return true;
    }
  }

  _register(email) async {
    if(validateEmail(email)) {
      setState(() {
        isLoading = true;
      });
      var response = await CallApi().postDataEnd(
          email, ecoins, 'ecoins_ganados');
      var body = json.decode(response.body);
      if(response.statusCode == 200 && int.parse(body["codigo"]) == 00) {
        widget.game.overlays.remove("Email");
        widget.game.resumeEngine();
      }
      else {
        setState(() {
          isLoading = false;
          isError = true;
          _errorMessage = "¡Error Interno del Servidor! Inténtalo de nuevo";
        });
      }
    }
    else {
      setState(() {
        isError = true;
      });
    }
  }

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
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            // color: Colors.amberAccent,
            child: new LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
              return Center(
                  child: Container(
                    // color: Colors.blue,
                    height: constraints.maxHeight*0.4,
                    width: constraints.maxWidth*0.45,
                    margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.47, 0, 0, 0),
                    child:  Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: constraints.maxHeight*0.15),
                        Container(
                          width: constraints.maxWidth*0.25,
                          height: constraints.maxHeight*0.07,
                          margin: EdgeInsets.fromLTRB(constraints.maxWidth*0.1,0, 0, 0),
                          padding: EdgeInsets.fromLTRB(0,0,0,14),
                          // color: Colors.green,
                          child: TextField(
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: constraints.maxHeight*0.025,
                                fontWeight: FontWeight.bold
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                            ),
                            controller: _controller,
                          ),
                        ),
                        isError ?
                          SizedBox(height: constraints.maxHeight*0.08,
                            child: Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: 12),))
                            :
                          SizedBox(height: constraints.maxHeight*0.085,),
                        isLoading ?
                        CircularProgressIndicator()
                            :
                        InkWell(
                          onTap: () {
                            _register(_controller.text);
                          },
                          child: Container(
                            // color: Colors.green,
                            height: constraints.maxHeight*0.07,
                            width: constraints.maxWidth*0.1,
                          ),
                        )
                      ],
                    )
                  )
              );
            })
          )
        ),
      )
    );
  }
}
