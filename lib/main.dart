import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  File _image;
  String _imagepath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadImage();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
              _imagepath != null
                ? CircleAvatar(backgroundImage: FileImage(File(_imagepath)), radius: 80,)

                :CircleAvatar(
                  radius: 80,
                  backgroundImage: _image != null ? FileImage(_image): NetworkImage('http://lentesocialmagazine.com/wp-content/uploads/2019/10/avatar-user-computer-icons-software-developer-avatar-981c07f6af5d56836fa1c9825f4872a7.png'),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: (){
                    PickImage();
                  },
                  child:Text("Pick image") ,
                ),
              ),
              RaisedButton(
                onPressed: (){
                  Saveimage(_image.path);
                },
                child:Text("Save image") ,
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void PickImage() async {

    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var image = await ImagePicker.getImage(source: ImageSource.gallery)
    setState(() {
      _image = image;
    });
  }

  Future<void> Saveimage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString("imagepath", path);

  }

  Future<void> LoadImage() async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveimage.getString("imagepath");
    });

  }
}




