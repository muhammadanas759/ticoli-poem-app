class StoryRatingResponse {
  String storyName;
  String userId;
  String storyId;
  var rating;
  var dropPercent;
  var audioPlayed;

  StoryRatingResponse({
    this.storyName,
    this.userId,
    this.storyId,
    this.rating,
    this.dropPercent,
    this.audioPlayed,
  });

  StoryRatingResponse.fromJson(dynamic json) {
    storyName = json["story_name"];
    userId = json["user_id"];
    storyId = json["story_id"];
    rating = json["rating"];
    dropPercent = json["drop_percent"];
    audioPlayed = json["audio_played"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["story_name"] = storyName;
    map["audio_played"] = audioPlayed;
    map["user_id"] = userId;
    map["story_id"] = storyId;
    map["rating"] = rating;
    map["drop_percent"] = dropPercent;
    return map;
  }
}
