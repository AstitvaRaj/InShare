import 'package:filetransfer/transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/qrcode.dart';
class rec extends StatefulWidget {
  @override
  _recState createState() => _recState();
}

class _recState extends State<rec> {
  String p="";
  QRCaptureController _captureController = QRCaptureController();
  bool _isTorchOn = false;
  @override
  void initState() {
    super.initState();

    _captureController.onCapture((data) {
      setState(() {
        p=data;
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>trans(filepathss: p,)
        ));

      });
      print('onCapture----$data');

    });
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.red,
        child: SafeArea(
          child:  Stack(
            alignment: Alignment.center,
            children: <Widget>[
              QRCaptureView(controller: _captureController),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white,
                  child: Text('$p'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildToolBar(),
              )
            ],
          ),
        ),
      ),

    );

  }
  Widget _buildToolBar() {
    return
      Container(child:Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            _captureController.pause();
          },
          child: Text('pause'),
        ),
        FlatButton(
          onPressed: () {
            if (_isTorchOn) {
              _captureController.torchMode = CaptureTorchMode.off;
            } else {
              _captureController.torchMode = CaptureTorchMode.on;
            }
            _isTorchOn = !_isTorchOn;
          },
          child: Text('torch'),
        ),
        FlatButton(
          onPressed: () {
            _captureController.resume();
          },
          child: Text('resume'),
        ),
      ],
    ));
  }
}

