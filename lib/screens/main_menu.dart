import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoins/game.dart';
import 'package:flame/game.dart';

class main_menu extends StatelessWidget {
  const main_menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/cocina.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Card(
            color: Colors.black.withOpacity(0.4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'ECOINS',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => GameWidget(
                                  game: EcoinsGame(),
                                )));
                      },
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
