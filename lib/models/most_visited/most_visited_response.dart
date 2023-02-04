class MostVisitedResponse {
  String storyName;
  int totalVisits;
  int audioPlayed;
  int animation;
  String storyId;

  MostVisitedResponse({
    this.storyName,
    this.totalVisits,
    this.storyId,
    this.audioPlayed,
    this.animation,
  });

  MostVisitedResponse.fromJson(dynamic json) {
    storyName = json["story_name"];
    totalVisits = json["total_visits"];
    storyId = json["story_id"];
    audioPlayed = json["audio_played"];
    animation = json["animation"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["story_name"] = storyName;
    map["total_visits"] = totalVisits;
    map["story_id"] = storyId;
    map["audio_played"] = audioPlayed;
    map["animation"] = animation;
    return map;
  }
}
