class ScreenTimeModel {
  String userId;
  String time;

  ScreenTimeModel({
      this.userId, 
      this.time});

  ScreenTimeModel.fromJson(dynamic json) {
    userId = json["user_id"];
    time = json["time"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = userId;
    map["time"] = time;
    return map;
  }

}