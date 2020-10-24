import 'dart:convert';
import 'dart:io';
import 'ImgurTagObject.dart';
import 'package:http/http.dart' as http;

class ImgurImageData {
  String accessToken;

  String id;
  String title;
  String description;
  int datetime;
  String type;
  bool animated;
  int width;
  int height;
  int size;
  int views;
  int bandwidth;
  String deletehash;
  String name;
  String section;
  String link;
  String gifv;
  String mp4;
  int mp4_size;
  bool looping;
  bool favorite;
  bool nsfw;
  String vote;
  bool in_gallery;
  int account_id;
  String account_url;

  String edited;
  bool has_sound;
  bool in_most_viral;
  bool is_ad;
  List<ImgurTag> tags;

  ImgurImageData({
    this.accessToken,
    this.account_id,
    this.account_url,
    this.animated,
    this.bandwidth,
    this.datetime,
    this.deletehash,
    this.description,
    this.edited,
    this.favorite,
    this.gifv,
    this.has_sound,
    this.height,
    this.id,
    this.in_gallery,
    this.in_most_viral,
    this.is_ad,
    this.link,
    this.mp4,
    this.mp4_size,
    this.name,
    this.nsfw,
    this.section,
    this.size,
    this.tags,
    this.title,
    this.type,
    this.views,
    this.vote,
    this.width,
    this.looping,
  });

  factory ImgurImageData.fromJson(
      Map<String, dynamic> json, String accessToken) {
    return ImgurImageData(
      accessToken: accessToken,
      id: json['id'],
      account_id: json['account_id'],
      account_url: json['account_url'],
      animated: json['animated'],
      bandwidth: json['bandwidth'],
      datetime: json['datetime'],
      deletehash: json['deletehash'],
      description: json['description'] != null ? json['description'] : null,
      edited: json['edited'].toString(),
      favorite: json['favorite'],
      has_sound: json['has_sound'],
      height: json['height'],
      in_gallery: json['in_gallery'],
      in_most_viral: json['in_most_viral'],
      is_ad: json['is_ad'],
      link: json['link'],
      mp4: json['mp4'],
      mp4_size: json['mp4_size'],
      nsfw: json['nsfw'] != null ? json['nsfw'] : false,
      section: json['section'] != null ? json['section'] : null,
      size: json['size'],
      tags: json['tags'] != null
          ? json['tags']
              .map<ImgurTag>((i) => ImgurTag.fromJson(i, accessToken))
              .toList()
          : null,
      title: json['title'] != null ? json['title'] : null,
      type: json['type'],
      views: json['views'],
      vote: json['vote'] != null ? json['vote'] : null,
      width: json['width'],
      name: json['name'] != null ? json['name'] : null,
      looping: json['looping'] != null ? json['looping'] : false,
    );
  }

  void favImage(String hash) async {
    print("https://api.imgur.com/3/image/$hash/favorite");
    final request = await http.post(
      "https://api.imgur.com/3/image/$hash/favorite",
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
    );
    bool res = await json.decode(request.body)['success'];
    if (res) {
      this.favorite = true;
    }
  }
}
