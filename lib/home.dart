import 'package:file_picker/file_picker.dart';
import 'package:filetransfer/recieve.dart';
import 'package:filetransfer/send.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'native.dart';
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
   void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    String filepath="";
    return Scaffold(
      drawer: Container(
        height:  height,
        width: width*0.8,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            right: BorderSide(
              color: Colors.white,
            )
          )
        ),

        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: height*0.3,
              ),
              GestureDetector(
                onTap:(){
                } ,
                child: Text('Profile',
                style: TextStyle(
                  color: Colors.white,
                ),),
              )
            ],
          )
        ),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: height*0.07,
                  child: Row(
                    children: <Widget>[
                      Container(width: 25,),
                      Icon(Icons.menu,color: Colors.white,),
                      Container(width: 20,),
                      Text('InShare',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "MeriendaOne",
                        fontSize: width*0.09,
                      ),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: height*0.77,
                    width: width,
                    decoration: BoxDecoration(

                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text('Select file',style: TextStyle(color: Colors.white),),
                            onPressed: () async{
                              Future <String> getfilepath= FilePicker.getFilePath();
                              setState(() async{
                                filepath =await  getfilepath;
                                print('$filepath');
                              });
                            },
                          ),
                          FlatButton(
                            child: Text('Send file',style: TextStyle(color: Colors.white),),
                            onPressed: ()async{
                              MethodChannel m = MethodChannel("filetransfer");
                              m.invokeMethod("sendfile",<String,dynamic>{
                                "path":filepath
                              });

                            },
                          ),
                        ],
                      ),
                    ),


                  ),
                ),
                Expanded(
                  child:Container(
                    height: height*0.075,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                        border: Border(
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            bottom: BorderSide(
                              color: Colors.white,
                            ),
                            left: BorderSide(
                              color: Colors.white,
                            ),
                            right: BorderSide(
                              color: Colors.white,
                            )
                        ),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            width: width*0.35,
                            height: height*0.06,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border(
                                  top: BorderSide(
                                    width: 3,
                                    color: Colors.greenAccent,
                                    style: BorderStyle.solid,

                                  ),
                                  bottom: BorderSide(
                                      width: 3,
                                      color: Colors.greenAccent,
                                      style: BorderStyle.solid
                                  ),
                                  left: BorderSide(
                                      width: 3,
                                      color: Colors.greenAccent,
                                      style: BorderStyle.solid
                                  ),
                                  right: BorderSide(
                                      width: 3,
                                      color: Colors.greenAccent,
                                      style: BorderStyle.solid
                                  ),

                                )
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.file_upload,
                                    color: Colors.white,
                                  ),
                                  Text('SEND',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 15
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            MethodChannel m = MethodChannel("filetransfer");
                            m.invokeMethod("sendfile",<String,dynamic>{
                              "path":filepath
                            });
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>senddata(filepath: filepath,)
                              )
                            );
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: width*0.35,
                            height: height*0.06,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                border: Border(
                                  top: BorderSide(
                                    width: 3,
                                    color: Colors.lightBlueAccent,
                                    style: BorderStyle.solid,

                                  ),
                                  bottom: BorderSide(
                                      width: 3,
                                      color: Colors.lightBlueAccent,
                                      style: BorderStyle.solid
                                  ),
                                  left: BorderSide(
                                      width: 3,
                                      color: Colors.lightBlueAccent,
                                      style: BorderStyle.solid
                                  ),
                                  right: BorderSide(
                                      width: 3,
                                      color: Colors.lightBlueAccent,
                                      style: BorderStyle.solid
                                  ),

                                )
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.file_download,color: Colors.white,),
                                  Text('Recieve',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        fontSize: 15
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>rec())
                            );
                          },
                        ),

                      ],
                    ),
                  ) ,
                )
                ,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
