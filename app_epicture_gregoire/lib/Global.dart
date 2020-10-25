import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'ImgurAccountObject.dart';
import 'ImgurGaleryObject.dart';
import 'ImgurImageObject.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class BasicCall {
  /// Const declaration
  static const String UploadTypeUrl = "URL";
  static const String UploadTypeFile = "file";
  static const String UploadTypeBase64 = "base64";

  bool _isLoggedIn;
  String _accountUsername;
  String _accountId;
  String _accessToken;
  BasicCall();

  void initvalue() {
    _isLoggedIn = false;
    _accountUsername = "value";
    _accountId = "value";
    _accessToken = "c14d214ee0f373d3bba492c7222fd0fb7f7f74cb";
  }

  Future<bool> fetchToken(bool val) async {
    if (val == true) {
      var result = await FlutterWebAuth.authenticate(
          url:
              "https://api.imgur.com/oauth2/authorize?client_id=$ImgurClientid&response_type=token",
          callbackUrlScheme: "epicture");

      result = result.substring(0, 11) + "?" + result.substring(12);
      _accessToken = Uri.parse(result).queryParameters['access_token'];
      _accountUsername = Uri.parse(result).queryParameters["account_username"];
      _accountId = Uri.parse(result).queryParameters["account_id"];
      _isLoggedIn = true;
      return true;
    }
    return false;
  }

  bool isLogged() {
    return _isLoggedIn;
  }

  String getToken() {
    return _accessToken;
  }

  Future<ImgurAccountBase> getMyAccount() async {
    // if (_isLoggedIn == false) {
    //   throw Exception("Not loggedin");
    // }
    final response = await http.get(
      "https://api.imgur.com/3/account/$_accountUsername",
      headers: {HttpHeaders.authorizationHeader: "Client-ID $ImgurClientid"},
    );
    return ImgurAccountBase.fromJson(
        json.decode(response.body)["data"], _accessToken, true);
  }

  Future<List<ImgurGallery>> getGallery({
    String section = "hot",
    String sort = "viral",
    String page = "0",
    String window = "day",
    String showViral = "true",
  }) async {
    if (_isLoggedIn == false) {
      print("Not loggedin");
      throw Exception("Not loggedin");
    }
    final response = await http.get(
      "https://api.imgur.com/3/gallery/$section/$sort/$window/$page?showViral=$showViral",
      headers: {HttpHeaders.authorizationHeader: "Bearer $_accessToken"},
    );
    return json
        .decode(response.body)["data"]
        .map<ImgurGallery>(
            (gallery) => ImgurGallery.fromJson(gallery, _accessToken))
        .toList();
  }

  Future<ImgurImageData> uploadImage({
    dynamic data,
    String name,
    String title,
    String description,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.imgur.com/3/image"));
    if (name != null) {
      request.fields["name"] = name;
    }
    if (title != null) {
      request.fields["title"] = title;
    }
    if (description != null) {
      request.fields["description"] = description;
    }
    request.files.add(http.MultipartFile.fromBytes("image", data));
    request.headers[HttpHeaders.authorizationHeader] = "Bearer $_accessToken";
    final http.StreamedResponse response = await request.send();
    final respBody = await response.stream.bytesToString();
    print(respBody);
    return ImgurImageData.fromJson(json.decode(respBody)["data"], _accessToken);
  }

  Future<List<ImgurGallery>> searchGallery(
      {String sort = "time",
      String window = "all",
      String page = "0",
      String query,
      String searchType}) async {
    if (_isLoggedIn == false) {
      print("Not loggedin");
      throw Exception("Not loggedin");
    }

    final uri = Uri.encodeFull(
        "https://api.imgur.com/3/gallery/search/$sort/$window/$page?q=${(searchType == null) ? '' : "$searchType:"}$query");
    final response = await http.get(
      uri,
      headers: {HttpHeaders.authorizationHeader: "Client-ID $ImgurClientid"},
    );
    print(response.body);
    return json
        .decode(response.body)["data"]
        .map<ImgurGallery>(
            (gallery) => ImgurGallery.fromJson(gallery, _accessToken))
        .toList();
  }
}

const ImgurClientid = "4307dca97df57f9";
// const ImgurAPISecret = "7e63730459a273ae05216b94654bcd384b0acdf1";

BasicCall _basicCall = BasicCall();
