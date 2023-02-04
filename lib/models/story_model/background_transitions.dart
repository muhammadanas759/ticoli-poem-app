class BackgroundTransitions {
  int itemRefId;
  String startColor;
  String endColor;
  String location;
  double duration;

  BackgroundTransitions({
      this.itemRefId, 
      this.startColor, 
      this.endColor, 
      this.location, 
      this.duration});

  BackgroundTransitions.fromJson(dynamic json) {
    itemRefId = json["itemRefId"];
    startColor = json["startColor"];
    endColor = json["endColor"];
    location = json["location"];
    duration = json["duration"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["itemRefId"] = itemRefId;
    map["startColor"] = startColor;
    map["endColor"] = endColor;
    map["location"] = location;
    map["duration"] = duration;
    return map;
  }

}