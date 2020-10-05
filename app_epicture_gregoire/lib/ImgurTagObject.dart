class ImgurTag {
  String accessToken;

  String accent;
  String background_hash;
  bool background_is_animated;
  String description;
  String display_name;
  int followers;
  bool following;
  bool is_promoted;
  bool is_whitelisted;
  String name;
  String thumbnail_hash;
  bool thumbnail_is_animated;
  int total_items;

  ImgurTag(
      {this.accessToken,
      this.accent,
      this.background_hash,
      this.background_is_animated,
      this.description,
      this.display_name,
      this.followers,
      this.following,
      this.is_promoted,
      this.is_whitelisted,
      this.name,
      this.thumbnail_hash,
      this.thumbnail_is_animated,
      this.total_items});

  factory ImgurTag.fromJson(Map<String, dynamic> json, String accessToken) {
    return ImgurTag(
      accessToken: accessToken,
      accent: json['accent'],
      background_hash: json['background_hash'],
      background_is_animated: json['background_is_animated'],
      description: json['description'],
      display_name: json['display_name'],
      followers: json['followers'],
      following: json['following'],
      is_promoted: json['is_promoted'],
      is_whitelisted: json['is_whitelisted'],
      name: json['name'],
      thumbnail_hash: json['thumbnail_hash'],
      thumbnail_is_animated: json['thumbnail_is_animated'],
      total_items: json['total_items'],
    );
  }
}
