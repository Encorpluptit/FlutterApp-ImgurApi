import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

import 'ImgurAccountObject.dart';
import 'ImgurGalleryObject.dart';

class Favorites extends StatefulWidget {
  ImgurAccountBase account;
  int index = 0;
  bool reload = false;
  Favorites({this.account});

  @override
  _Favorites createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  void reload() {
    setState(() {widget.reload = !widget.reload;});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: widget.account.getFavoriteImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              inspect(snapshot.data);
              return Container(
                  child: Wrap(
                      direction: Axis.vertical,
                      children: List.generate(
                snapshot.data.length,
                (index) {
                  if (snapshot.data[index].in_gallery == false)
                    return FavoriteImage(
                      image: snapshot.data.elementAt(index),
                      id: snapshot.data[index].id,
                      reloadPage: (ImgurGallery obj) {snapshot.data.remove(obj);sleep(Duration(milliseconds: 750));reload();},
                    );
                  return Container();
                },
              )));
            } else if (snapshot.hasError) {
              return Text("ERROR");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class FavoriteImage extends StatefulWidget {
  String id;
  ImgurGallery image;
  Function reloadPage;

  FavoriteImage({this.image, this.id, this.reloadPage});

  @override
  FavoriteImageState createState() => FavoriteImageState();
}

class FavoriteImageState extends State<FavoriteImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 3,
        width: MediaQuery.of(context).size.width / 3,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color.fromARGB(255, 203, 175, 135),
          elevation: 10,
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (_) => FavImageDialog(
                        image: widget.image,
                        id: widget.id,
                        reloadPage: widget.reloadPage,
                      ));
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.image.images.first.link)),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ));
  }
}

class FavImageDialog extends StatefulWidget {
  ImgurGallery image;
  String id;
  Function reloadPage;

  FavImageDialog({this.image, this.id, this.reloadPage});

  @override
  _FavImageDialog createState() => _FavImageDialog();
}

class _FavImageDialog extends State<FavImageDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.image.favorite);
    return AlertDialog(
      insetPadding: EdgeInsets.all(8.0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: FittedBox(
          child: ClipRRect(
            child: Image.network(
              widget.image.link,
              height: 95.0,
              width: 95.0,
            ),
          ),
          fit: BoxFit.fill,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite),
          iconSize: 40,
          color: Colors.blue,
          onPressed: () {
            widget.image.favGalery(widget.id);
            widget.image.images.first.favImage();
            widget.reloadPage(widget.image);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
