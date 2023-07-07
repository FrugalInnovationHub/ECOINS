import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  final game;
  const EmailTextField({super.key, this.game});

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
                        SizedBox(height: constraints.maxHeight*0.085,),
                        InkWell(
                          onTap: () {
                            widget.game.overlays.remove("Email");
                            widget.game.resumeEngine();
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
