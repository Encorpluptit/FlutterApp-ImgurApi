import 'package:flutter/material.dart';

import 'ImgurAccountObject.dart';
import 'ImgurGaleryObject.dart';

class Account extends StatelessWidget {
  ImgurAccountBase account;

  Account({this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImgurGallery>>(
          future: account.getPersonalImages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (var item in snapshot.data)
                print(item.favorite_count);
              print(account.reputationName);
              return ListView(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        AccountAvatar(src: account.avatar),
                        SizedBox(height: 20),
                        AccountInfos(url: account.url, bio: account.bio),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  // AccountCardLike(subtitle: 5, list: snapshot.data),
                                  AccountCardLike(
                                    () {
                                      int count = 0;
                                      for (var item in snapshot.data)
                                        count += item.points;
                                      return count;
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  AccountCardFollow(subtitle: 5),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  AccountCardView(
                                    () {
                                      int count = 0;
                                      // for (var item in snapshot.data)
                                      //   print(item.favorite_count);
                                      for (var item in snapshot.data)
                                        count += item.views;
                                      return count;
                                    },
                                  ),
                                  // AccountCardLike(subtitle: 5),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Wrap(
                                children: List.generate(
                          snapshot.data.length,
                          (index) {
                            print(snapshot.data
                                .elementAt(index)
                                .images
                                .first
                                .link);
                            return AccountCardImage(
                              src: snapshot.data
                                  .elementAt(index)
                                  .images
                                  .first
                                  .link,
                            );
                          },
                        )))
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              print('error');
              return Text("${snapshot.error}");
            }
            print("lol");
            return CircularProgressIndicator();
          }),
    );
  }
}

class AccountCardLike extends AccountCardInfos {
  static const String staticTitle = "Likes";
  final int Function() count;

  AccountCardLike(this.count, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountCardInfos(
        title: staticTitle,
        value: this.count(),
        icon: Icon(Icons.thumb_up_outlined, size: 20));
  }
}

class AccountCardView extends AccountCardInfos {
  static const String staticTitle = "Views";
  final int Function() count;

  AccountCardView(this.count, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountCardInfos(
        title: staticTitle,
        value: this.count(),
        icon: Icon(Icons.remove_red_eye_outlined, size: 20));
  }
}

class AccountCardFollow extends AccountCardInfos {
  static const String staticTitle = "Follows";

  const AccountCardFollow({Key key, int subtitle})
      : super(key: key, value: subtitle);

  @override
  Widget build(BuildContext context) {
    return AccountCardInfos(
        title: staticTitle,
        value: this.value,
        icon: Icon(Icons.supervised_user_circle_rounded, size: 20));
  }
}

class AccountCardInfos extends StatelessWidget {
  final String title;
  final int value;
  final Widget icon;

  const AccountCardInfos({Key key, this.title, this.value, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20),
            icon,
            ListTile(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
              ),
              subtitle: Text(value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountCardImage extends StatelessWidget {
  final String src;

  const AccountCardImage({Key key, this.src}) : super(key: key);

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
                builder: (_) => ImageDialog(src: src)
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(src)),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ));
  }
}

class AccountAvatar extends StatelessWidget {
  final String src;

  const AccountAvatar({Key key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: CircleAvatar(
          radius: 100,
          backgroundColor: Color.fromARGB(255, 48, 71, 94),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45.0),
            child: Image.network(
              src,
              height: 95.0,
              width: 95.0,
            ),
          ),
        ));
  }
}

class AccountInfos extends StatelessWidget {
  final String url;
  final String bio;

  const AccountInfos({Key key, this.url, this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 203, 175, 135),
      ),
      alignment: Alignment.center,
      child: ListTile(
        title: Text(
          url,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
        ),
        subtitle: Text(
          bio != null ? bio : "No Description",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String src;

  const ImageDialog({Key key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        // height: 200,
        child: FittedBox(
          child: Image.network(src),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}