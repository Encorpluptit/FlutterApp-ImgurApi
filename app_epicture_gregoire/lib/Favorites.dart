import 'package:app_epicture_gregoire/ImgurImageObject.dart';
import 'package:flutter/material.dart';

import 'ImgurAccountObject.dart';
import 'ImgurGaleryObject.dart';

class Favorites extends StatefulWidget {
  ImgurAccountBase account;

  Favorites({this.account});

  @override
  _Favorites createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: widget.account.getFavoriteImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Wrap(
                      children: List.generate(
                snapshot.data.length,
                (index) {
                  print(snapshot.data.elementAt(index).images.first.link);
                  print(snapshot.data.elementAt(index).favorite_count);
                  return FavoriteImage(
                      image: snapshot.data.elementAt(index).images.first);
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
  ImgurImageData image;

  FavoriteImage({this.image});

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
                  builder: (_) => FavImageDialog(image: widget.image));
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.image.link)),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),

              // child: IconButton(
              //   icon: Icon(Icons.android),
              //   iconSize: 5,
              //   color: Colors.white,
              //   onPressed: () {},
              // ),
            ),
          ),
        ));
  }
}

class FavImageDialog extends StatefulWidget {
  ImgurImageData image;

  FavImageDialog({this.image});

  @override
  _FavImageDialog createState() => _FavImageDialog();
}

class _FavImageDialog extends State<FavImageDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.image.favorite);
    return AlertDialog(
      // title: Text(widget.image.title ),
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
          // padding: EdgeInsets.all(8.0),
          icon: Icon(Icons.favorite),
          iconSize: 40,
          color: Colors.blue,
          onPressed: () {
            widget.image.favImage(widget.image.id.toString());
            Navigator.of(context).pop();
            Navigator.of(context).reassemble();
          },
        ),
      ],
    );
  }
}
