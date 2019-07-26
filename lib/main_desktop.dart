import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var tasmpath=ValueNotifier("/home/nlab37/tasm/TASM");
var inputc = TextEditingController();
Process p;

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;  
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TASMEd',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TASMEd'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: inputc,
                keyboardType: TextInputType.multiline,
                maxLines: 1000,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          try{
            p.kill();
          }catch(e){

          }
          var file=File(tasmpath.value+"/tmp.asm");
          await file.writeAsString(inputc.text);
          p=await Process.start("dosbox", ["-c","mount c ${tasmpath.value}","-c","C:","-c","tasm tmp.asm","-c","tlink tmp","-c","tmp"]);
        },
        tooltip: 'Play',
        child: Icon(Icons.play_arrow),
      ), 
    );
  }
}
