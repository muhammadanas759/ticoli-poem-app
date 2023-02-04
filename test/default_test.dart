import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horror_story/models/background_transition.dart';

import 'dart:convert';

import 'package:horror_story/models/story.dart';
import 'package:horror_story/models/story_image_item.dart';
import 'package:horror_story/models/story_text_item.dart';
import 'package:horror_story/models/story_transition_image_item.dart';

void main() {
  Story mainStory = Story(
    date: DateTime(2021, 1, 31),
    coverImageAsset: 'assets/images/cover-tale-ghot-in-masung-tunnel.png',
    coverTitleAsset: 'assets/images/title-tale-ghost-in-masung-tunnel.png',
    paddingTop: 919,
    paddingBottom: 99,
    backgroundTransitions: [
      BackgroundTransition(
        startColor: "#ffffff",
        endColor: "#1d283b",
        itemRefId: 1,
      )
    ],
    items: [
      StoryTextItem(
        content: 'It happened several years ago.',
        color: '#939394',
      ),
      StoryImageItem(
        gap: 160,
        asset: 'assets/images/image-1.png',
      ),
      StoryTextItem(
        gap: 214,
        content: 'I was on my way to my hometown, alone, on an express bus.',
        color: '#939394',
      ),
      StoryImageItem(
        gap: 160,
        horizontalGap: 75,
        asset: 'assets/images/image-2.png',
      ),
      StoryImageItem(
          gap: 214,
          horizontalGap: 75,
          asset: 'assets/images/image-3-eyes-close-up.png'),
      StoryImageItem(
          gap: 60,
          horizontalGap: 75,
          asset: 'assets/images/image-4-eyes-close-up.png'),
      StoryTextItem(
        color: '#939394',
        gap: 706,
        content: 'There was only 10 or less passengers seated here and there.',
      ),
      StoryTextItem(
        color: '#939394',
        gap: 156,
        content:
            'As the bus slid into a tunnel, with the surrounding becoming dark..',
      ),
      TransitionStoryImageItem(
        gap: 105,
        horizontalGap: 75,
        initialAsset: 'assets/images/image-5-back-seat-bright.png',
        finalAsset: 'assets/images/image-6-back-seat-dark.png',
      ),
      StoryImageItem(
          gap: 75, horizontalGap: 75, asset: 'assets/images/image-7.png'),
      StoryImageItem(
          gap: 1912,
          horizontalGap: 75,
          asset: 'assets/images/image-8-lights.png'),
      StoryImageItem(
          gap: 596,
          horizontalGap: 75,
          asset: 'assets/images/image-9-lights.png'),
      StoryImageItem(
          gap: 2390, horizontalGap: 75, asset: 'assets/images/image-10.png'),
      StoryImageItem(
          gap: 875, horizontalGap: 75, asset: 'assets/images/image-11.png'),
      StoryImageItem(
          gap: 82,
          horizontalGap: 75,
          asset: 'assets/images/image-12-dead-people.png'),
      StoryImageItem(
          gap: 1426,
          horizontalGap: 75,
          asset: 'assets/images/image-13-close-up.png'),
      StoryImageItem(
          gap: 74, horizontalGap: 75, asset: 'assets/images/image-10.png'),
      StoryImageItem(
          gap: 203,
          horizontalGap: 75,
          asset: 'assets/images/image-17-creature.png'),
      StoryImageItem(
          gap: 312,
          horizontalGap: 75,
          asset: 'assets/images/image-18-knife.png'),
      StoryImageItem(
          gap: 309,
          horizontalGap: 75,
          asset: 'assets/images/image-18-creature.png'),
      StoryImageItem(gap: 748, asset: 'assets/images/image-19.png'),
      StoryImageItem(
          gap: 682, horizontalGap: 75, asset: 'assets/images/image-20.png'),
      StoryImageItem(
          gap: 414, horizontalGap: 75, asset: 'assets/images/image-21.png'),
      StoryImageItem(gap: 206, asset: 'assets/images/image-22.png'),
      StoryImageItem(
          gap: 84, horizontalGap: 75, asset: 'assets/images/image-23.png'),
      StoryImageItem(
          gap: 1366,
          horizontalGap: 75,
          asset: 'assets/images/image-24-waking-up.png'),
      StoryTextItem(
        gap: 74,
        align: TextAlign.center,
        color: '#000000',
        content: 'I woke up to find myself in a hospital ward.',
      ),
      StoryTextItem(
        gap: 302,
        color: '#000000',
        content:
            'There might have been a terrible accident. TV newsman went on and on to report this accident every day.',
      ),
      StoryImageItem(
        gap: 253,
        horizontalGap: 75,
        asset: 'assets/images/image-25-bus.png',
      ),
      StoryTextItem(
        gap: 73,
        color: '#000000',
        content:
            'The bus collision left only myself and another passenger alive, there were 8 dead, including the driver.',
      ),
      StoryTextItem(
        gap: 157,
        color: '#000000',
        content:
            'People say I was in come for 2 days with a severe damage in my leg and an injury in the head. It really was a major accident but, they say, I survived because of the seat belt, that protected me from boucing out of the bus.',
      ),
      StoryTextItem(
        gap: 142,
        color: '#000000',
        content:
            'I tried to convince the doctor, nurses and even police officers investigating the case about the kid I saw on the bus...',
      ),
      StoryImageItem(
        gap: 225,
        horizontalGap: 75,
        asset: 'assets/images/image-26.png',
      ),
      StoryTextItem(
        gap: 149,
        color: '#000000',
        content: '...but no one seemed to believe me.',
      ),
      StoryImageItem(
        gap: 197,
        horizontalGap: 75,
        asset: 'assets/images/image-27.png',
      ),
      StoryTextItem(
        gap: 383,
        color: '#ffffff',
        content: 'Another survivor is still in coma.',
      ),
      StoryImageItem(
        gap: 99,
        horizontalGap: 75,
        asset: 'assets/images/image-28.png',
      ),
      StoryImageItem(
        gap: 52,
        horizontalGap: 75,
        asset: 'assets/images/image-29.png',
      ),
      StoryTextItem(
        gap: 99,
        color: '#ffffff',
        content: 'He is in a ward right next to mine.',
      ),
      StoryTextItem(
        gap: 99,
        color: '#ffffff',
        content: 'That person probably might have seen what I saw on the bus.',
      ),
      StoryImageItem(
        gap: 147,
        horizontalGap: 75,
        asset: 'assets/images/image-30.png',
      ),
      StoryTextItem(
        gap: 139,
        color: '#ffffff',
        content:
            'There buried a family in mountain Seok.sung located in Yongin-si, Gyeonggi-do, decapitated to death, due to a wronfgul accusation as traitors by king Gwan-hae. One of them was a little child who just started to say a few words. A spirit of a young child looking like a falt rotten corpse used to come down to a village and claimed tens of people\'s life.',
      ),
      StoryTextItem(
        gap: 215,
        color: '#ffffff',
        content:
            'Having heard about the tragic story, Gwang-hae placed a large rock on at the field where the family is buried, and the ghost of a child was never to be seen again.',
      ),
      StoryTextItem(
        gap: 167,
        color: '#ffffff',
        content:
            'Masung tunnel where the accident took place runs through mt. Seok-sung and was open for traffic in 1994.',
      ),
      StoryImageItem(
        gap: 163,
        horizontalGap: 75,
        asset: 'assets/images/image-31.png',
      ),
      StoryImageItem(
        gap: 147,
        horizontalGap: 75,
        asset: 'assets/images/image-32.png',
      ),
      StoryImageItem(
        gap: 147,
        horizontalGap: 75,
        asset: 'assets/images/image-33.png',
      ),
      StoryImageItem(
        gap: 147,
        horizontalGap: 75,
        asset: 'assets/images/image-34.png',
      ),
      StoryImageItem(
        gap: 116,
        horizontalGap: 75,
        asset: 'assets/images/image-35.png',
      ),
      StoryTextItem(
        gap: 166,
        color: '#ffffff',
        content: 'The End.',
      ),
    ],
  );

  test('just a single test', () {
    String serialized = jsonEncode(mainStory.toJson());
    print(serialized);
    var newStory = Story.fromJson(jsonDecode(serialized));
    print(newStory.items.length);
  });
}
