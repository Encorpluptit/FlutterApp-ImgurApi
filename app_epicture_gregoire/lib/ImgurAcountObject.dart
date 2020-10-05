import 'ImgurGaleryObject.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'HomeCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ImgurGaleryObject.dart';
import 'dart:io';

class ImgurAccountBase {
  final String accessToken;
  final bool isConnected;
  final String avatar;
  final String cover;
  final String bio;
  final int created;
  final int id;
  final bool pro_expiration;
  final int reputation;
  final String reputation_name;
  final String url;
  final bool user_follow;

  ImgurAccountBase(
      {this.accessToken,
      this.isConnected,
      this.avatar,
      this.bio,
      this.created,
      this.id,
      this.pro_expiration,
      this.reputation,
      this.reputation_name,
      this.url,
      this.user_follow,
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
        pro_expiration: json['pro_expiration'],
        reputation: json['reputation'],
        reputation_name: json['reputation_name'],
        url: json['url'],
        user_follow: json['user_follow']['status'],
        cover: json['cover']);
  }
}
