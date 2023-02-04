import 'background_transitions.dart';
import 'items.dart';
import 'audio_items.dart';

class Storys {
  String storyId;
  String zipFileName;
  String assetPackageUrl;
  String localDir;
  String coverImageAsset;
  String coverTitleAsset;
  String title;
  String homeCoverAsset;
  String thumbnailAsset;
  int duration;
  dynamic date;
  String catalogType;
  int paddingTop;
  int paddingBottom;
  String fontFamily;
  int fontSize;
  List<BackgroundTransitions> backgroundTransitions;
  List<Items> items;
  List<AudioItems> audioItems;

  Storys({
      this.storyId, 
      this.zipFileName, 
      this.assetPackageUrl, 
      this.localDir, 
      this.coverImageAsset, 
      this.coverTitleAsset, 
      this.title, 
      this.homeCoverAsset, 
      this.thumbnailAsset, 
      this.duration, 
      this.date, 
      this.catalogType, 
      this.paddingTop, 
      this.paddingBottom, 
      this.fontFamily, 
      this.fontSize, 
      this.backgroundTransitions, 
      this.items, 
      this.audioItems});

  Storys.fromJson(dynamic json) {
    storyId = json["storyId"];
    zipFileName = json["zipFileName"];
    assetPackageUrl = json["assetPackageUrl"];
    localDir = json["localDir"];
    coverImageAsset = json["coverImageAsset"];
    coverTitleAsset = json["coverTitleAsset"];
    title = json["title"];
    homeCoverAsset = json["homeCoverAsset"];
    thumbnailAsset = json["thumbnailAsset"];
    duration = json["duration"];
    date = json["date"];
    catalogType = json["catalogType"];
    paddingTop = json["paddingTop"];
    paddingBottom = json["paddingBottom"];
    fontFamily = json["fontFamily"];
    fontSize = json["fontSize"];
    if (json["backgroundTransitions"] != null) {
      backgroundTransitions = [];
      json["backgroundTransitions"].forEach((v) {
        backgroundTransitions.add(BackgroundTransitions.fromJson(v));
      });
    }
    if (json["items"] != null) {
      items = [];
      json["items"].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
    if (json["audioItems"] != null) {
      audioItems = [];
      json["audioItems"].forEach((v) {
        audioItems.add(AudioItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["storyId"] = storyId;
    map["zipFileName"] = zipFileName;
    map["assetPackageUrl"] = assetPackageUrl;
    map["localDir"] = localDir;
    map["coverImageAsset"] = coverImageAsset;
    map["coverTitleAsset"] = coverTitleAsset;
    map["title"] = title;
    map["homeCoverAsset"] = homeCoverAsset;
    map["thumbnailAsset"] = thumbnailAsset;
    map["duration"] = duration;
    map["date"] = date;
    map["catalogType"] = catalogType;
    map["paddingTop"] = paddingTop;
    map["paddingBottom"] = paddingBottom;
    map["fontFamily"] = fontFamily;
    map["fontSize"] = fontSize;
    if (backgroundTransitions != null) {
      map["backgroundTransitions"] = backgroundTransitions.map((v) => v.toJson()).toList();
    }
    if (items != null) {
      map["items"] = items.map((v) => v.toJson()).toList();
    }
    if (audioItems != null) {
      map["audioItems"] = audioItems.map((v) => v.toJson()).toList();
    }
    return map;
  }

}