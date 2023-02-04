class AppRatingResponse {
  String userId;
  var appRating;

  AppRatingResponse({this.userId, this.appRating});

  AppRatingResponse.fromJson(dynamic json) {
    userId = json["user_id"];
    appRating = json["app_rating"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["app_rating"] = appRating;
    return map;
  }
}
