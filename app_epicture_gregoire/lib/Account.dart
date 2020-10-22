import 'package:flutter/material.dart';

import 'ImgurAcountObject.dart';
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
              return ListView(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width / 4,
                          // height: 110,
                          // width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.album),
                        ),
                        // SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          child: ListTile(
                            // leading: Icon(Icons.album, size: 50),
                            title:  Text(
                              account.url,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 40),
                            ),
                            subtitle: Text(
                              account.bio != null ? account.bio : "No Description",
                              // 'TWICE',
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // child: Text(
                          //   account.url,
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600, fontSize: 20),
                          // ),

                          // child: Text(
                          //   account.url,
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600, fontSize: 20),
                          // ),

                        ),
                        SizedBox(height: 20),

                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 16),
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
                                  AccountCardFav(
                                        () {
                                      int count = 0;
                                      // for (var item in snapshot.data)
                                      //   count += item.favorite_count;
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

class AccountCardFav extends AccountCardInfos {
  static const String staticTitle = "Favorite";
  final int Function() count;

  AccountCardFav(this.count, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountCardInfos(
        title: staticTitle,
        value: this.count(),
        icon: Icon(Icons.favorite_border_outlined, size: 20));
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
  // final Color cardColor;

  const AccountCardImage({Key key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[310],
      height: MediaQuery.of(context).size.width / 3,
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey,
        elevation: 10,
        // child: Image.network(src)
        child: Container(
            // color: Colors.grey,
            child: Image.network(src)),
      ),
    );
  }
}
