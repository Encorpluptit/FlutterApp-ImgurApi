import 'ImgurGaleryObject.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ImgurAccountBase {
  final String accessToken;
  final bool isConnected;
  final String avatar;
  final String cover;
  final String bio;
  final int created;
  final int id;
  final bool proExpiration;
  final int reputation;
  final String reputationName;
  final String url;
  final bool userFollow;

  ImgurAccountBase(
      {this.accessToken,
      this.isConnected,
      this.avatar,
      this.bio,
      this.created,
      this.id,
      this.proExpiration,
      this.reputation,
      this.reputationName,
      this.url,
      this.userFollow,
      this.cover});

  factory ImgurAccountBase.fromJson(
      Map<String, dynamic> json, accessToken, isConnected) {
    return ImgurAccountBase(
        accessToken: accessToken,
        isConnected: isConnected,
        avatar: json['avatar'] != null ? json['avatar'] : null,
        bio: json['bio'] != null ? json['bio'] : null,
        created: json['created'],
        id: json['id'],
        proExpiration: json['pro_expiration'],
        reputation: json['reputation'],
        reputationName: json['reputation_name'],
        url: json['url'],
        userFollow: json['user_follow']['status'],
        cover: json['cover']);
  }

  Future<List<ImgurGallery>> getPersonalImages() async {
    final response = await http.get(
      "https://api.imgur.com/3/account/$url/images",
      headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
    );
    print("json value");
    return json
        .decode(response.body)['data']
        .map<ImgurGallery>((image) => ImgurGallery.fromJson(image, accessToken))
        .toList();
  }
}
