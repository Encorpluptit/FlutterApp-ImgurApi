import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'Global.dart';

class AddPost extends StatefulWidget {
  BasicCall user;
  AddPost({this.user});
  @override
  PostState createState() => PostState();
}

class PostState extends State<AddPost> {
  int postState = 1;
  File _image;
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: checkState(),
    );
  }

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
      postState = 4;
    });
  }

  _imgFromGallery() async {
    var pickImage =
        // ignore: deprecated_member_use
        ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File image = await pickImage;

    setState(() {
      _image = image;
      postState = 4;
    });
  }

  Widget checkState() {
    if (postState == 1) {
      return initStateforPost();
    }
    if (postState == 2) {
      return fromgallery();
    }
    if (postState == 3) {
      return fromPhoto();
    }
    if (postState == 4) {
      if (_image == null)
        setState(() {
          postState = 1;
        });
      return buildPost();
    }
    return Text("ohh it's semme broken");
  }

  Widget fromgallery() {
    _imgFromGallery();
    return Text("world");
  }

  Widget fromPhoto() {
    _imgFromCamera();
    return Text("photo");
  }

  Widget buildPost() {
    return Column(
      children: [
        Container(height: 50),
        TextField(
          controller: myController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Title (needed)',
          ),
        ),
        Image.file(_image),
        TextField(
          controller: myController2,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'comment',
          ),
        ),
        RaisedButton(
          onPressed: () {
            setState(() {
              widget.user.uploadImage(
                data: _image.readAsBytesSync(),
                title: myController.text,
                description: myController2.text,
              );
              postState = 1;
            });
          },
          child: Text(
            "PUSH THAT",
            style: TextStyle(fontSize: 25),
          ),
          elevation: 10,
          textColor: Colors.grey[700],
          color: Color.fromARGB(255, 231, 222, 200),
          highlightElevation: 0,
        ),
      ],
    );
  }

  Widget initStateforPost() {
    return Column(
      children: [
        Container(height: 200),
        Container(
          width: 270,
          height: 100,
          child: RaisedButton(
            onPressed: () {
              setState(() {
                postState = 2;
              });
            },
            child: Text(
              "Select From Galery",
              style: TextStyle(fontSize: 25),
            ),
            elevation: 10,
            textColor: Colors.grey[700],
            color: Color.fromARGB(255, 231, 222, 200),
            highlightElevation: 0,
          ),
        ),
        Container(height: 10),
        Container(
          width: 270,
          height: 100,
          child: RaisedButton(
            onPressed: () {
              setState(() {
                postState = 3;
              });
            },
            child: Text(
              "Take a picture",
              style: TextStyle(fontSize: 25),
            ),
            elevation: 10,
            textColor: Colors.grey[700],
            color: Color.fromARGB(255, 231, 222, 200),
            highlightElevation: 0,
          ),
        ),
      ],
    );
  }
}
