import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class senddata extends StatefulWidget {
  @override
  _senddataState createState() => _senddataState();
}

class _senddataState extends State<senddata> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: height*0.2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20,bottom: 50),
                  child: Center(
                    child: Text(
                      'Scan To Connect',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  height: width*0.6,
                  width: width*0.6,
                  child: QrImage(
                    padding: EdgeInsets.all(15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    data: 'Astitva Raj',
                    version: 7,
                    size: 350,
                    gapless: true,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Uh oh! Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
