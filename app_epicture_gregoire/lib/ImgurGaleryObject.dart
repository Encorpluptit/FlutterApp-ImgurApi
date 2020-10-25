import 'dart:convert';
import 'dart:developer';

import 'ImgurImageObject.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImgurGallery {
  String accessToken;
  int account_id;
  String account_url;
  int ad_type;
  String ad_url;
  int comment_count;
  String cover;
  int cover_height;
  int cover_width;
  int datetime;
  String description;
  int downs;
  bool favorite;
  int favorite_count;
  String id;
  List<ImgurImageData> images;
  int images_count;
  bool in_gallery;
  bool in_most_viral;
  bool include_album_ads;
  bool is_ad;
  bool is_album;
  String layout;
  String link;
  bool nsfw;
  int points;
  String privacy;
  int score;
  String section;
  String title;
  String topic;
  int topic_id;
  int ups;
  int views;
  String vote;

  ImgurGallery(
      {this.accessToken,
      this.account_id,
      this.account_url,
      this.ad_type,
      this.ad_url,
      this.comment_count,
      this.cover,
      this.cover_height,
      this.cover_width,
      this.datetime,
      this.description,
      this.downs,
      this.favorite,
      this.favorite_count,
      this.id,
      this.images,
      this.images_count,
      this.in_gallery,
      this.in_most_viral,
      this.include_album_ads,
      this.is_ad,
      this.is_album,
      this.layout,
      this.link,
      this.nsfw,
      this.points,
      this.privacy,
      this.score,
      this.section,
      this.title,
      this.topic,
      this.topic_id,
      this.ups,
      this.views,
      this.vote});

  factory ImgurGallery.fromJson(Map<String, dynamic> json, String accessToken) {
    return ImgurGallery(
      accessToken: accessToken,
      account_id: json['account_id'],
      account_url: json['account_url'],
      ad_type: json['ad_type'],
      ad_url: json['ad_url'],
      comment_count: json['comment_count'],
      cover: json['cover'],
      cover_height: json['cover_height'],
      cover_width: json['cover_width'],
      datetime: json['datetime'],
      description: json['description'],
      downs: json['downs'],
      favorite: json['favorite'],
      favorite_count:
          json['favorite_count'] != null ? json['favorite_count'] : 0,
      id: json['id'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((i) => ImgurImageData.fromJson(i, accessToken))
              .toList()
          : [ImgurImageData.fromJson(json, accessToken)],
      images_count: json['images_count'],
      in_gallery: json['in_gallery'],
      in_most_viral: json['in_most_viral'],
      include_album_ads: json['include_album_ads'],
      is_ad: json['is_ad'],
      is_album: json['is_album'],
      layout: json['layout'],
      link: json['link'],
      nsfw: json['nsfw'],
      points: json['points'] != null ? json['points'] : 0,
      privacy: json['privacy'],
      score: json['score'],
      section: json['section'],
      title: json['title'],
      topic: json['topic'],
      ups: json['ups'] != null ? json['ups'] : 0,
      views: json['views'],
      vote: json['vote'],
    );
  }
  void favGalery(String value) async {
    final request = await http.post(
      "https://api.imgur.com/3/album/$value/favorite",
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
    );
  }

  Future<bool> upvote() async {
    if (vote == "up") {
      bool res = await _setVote("veto");
      if (res) {
        vote = null;
        ups -= 1;
      }
      return res;
    }
    bool res = await _setVote("up");
    if (res) {
      vote = "up";
      ups += 1;
    }
    return res;
  }

  Future<bool> downvote() async {
    if (vote == "down") {
      bool res = await _setVote("veto");
      if (res) {
        vote = null;
        downs -= 1;
      }
      return res;
    }
    bool res = await _setVote("down");
    if (res) {
      vote = "down";
      downs += 1;
    }
    return res;
  }

  Future<bool> _setVote(vote) async {
    final response = await http.post(
      "https://api.imgur.com/3/gallery/$id/vote/$vote",
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
    );
    Map<String, dynamic> res = json.decode(response.body);
    return res['success'];
  }
}
