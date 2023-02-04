import 'package:horror_story/models/background_transition.dart';
import 'package:horror_story/models/catalog_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'audio_item.dart';
import 'story_item.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
   String storyId;
   String coverTitleAsset;
   String coverImageAsset;
   double paddingTop;
   double paddingBottom;
   String fontFamily;
   double fontSize;

   List<StoryItem> items;
   List<AudioItem> audioItems;
   List<BackgroundTransition> backgroundTransitions;

  // copied from old catalog
   String title;
   String homeCoverAsset;
   String thumbnailAsset;
   int duration;
   DateTime date;
   CatalogType catalogType;

  // additional data
   String zipFileName;
   String assetPackageUrl;
   String localDir;

  Story({
    this.storyId,
    this.coverTitleAsset,
    this.coverImageAsset,
    this.paddingTop,
    this.paddingBottom,
    this.fontFamily,
    this.fontSize,
    this.items,
    this.backgroundTransitions,
    this.audioItems,
    this.title,
    this.homeCoverAsset,
    this.thumbnailAsset,
    this.catalogType,
    this.duration,
    this.date,
    this.assetPackageUrl,
    this.localDir,
    this.zipFileName,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
