class AudioItems {
  String asset;
  int startItemRefId;
  int endItemRefId;

  AudioItems({
      this.asset, 
      this.startItemRefId, 
      this.endItemRefId});

  AudioItems.fromJson(dynamic json) {
    asset = json["asset"];
    startItemRefId = json["startItemRefId"];
    endItemRefId = json["endItemRefId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["asset"] = asset;
    map["startItemRefId"] = startItemRefId;
    map["endItemRefId"] = endItemRefId;
    return map;
  }

}