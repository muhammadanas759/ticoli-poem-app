import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:archive/archive_io.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horror_story/controllers/rating_controller.dart';
import 'package:horror_story/models/audio_item.dart';
import 'package:horror_story/models/most_visited/most_visited_response.dart';
import 'package:horror_story/models/story.dart';
import 'package:horror_story/models/story_image_item.dart';
import 'package:horror_story/models/story_item.dart';
import 'package:horror_story/models/story_text_item.dart';
import 'package:horror_story/models/story_transition_image_item.dart';
import 'package:horror_story/models/story_video_item.dart';
import 'package:horror_story/screens/pink_show_story_wdget.dart';
import 'package:horror_story/utils/app_utills.dart';
import 'package:horror_story/utils/audio_manager.dart';
import 'package:horror_story/utils/file_aux.dart';
import 'package:horror_story/utils/hex_color.dart';
import 'package:horror_story/utils/size_manager.dart';
import 'package:horror_story/widgets/story_cover.dart';
import 'package:horror_story/widgets/story_image.dart';
import 'package:horror_story/widgets/story_text.dart';
import 'package:horror_story/widgets/transition_story_image.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class StoryPage extends StatefulWidget {
  final Story story;
  final storyRating;
  final total;
  final userStoryReadCount;
  final dir;
  TextStyle fontsTyp;

  StoryPage({
    Key key,
    this.story,
    this.storyRating,
    this.total,
    this.userStoryReadCount,
    this.dir,
    this.fontsTyp,
  }) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  AudioManager _audioManager;

  Color _backgroundColor;
  bool _containsImageTransition;
  bool _containsVideo;
  bool _containsAudio;

  bool _downloading = false;
  bool _loading = true;
  bool _isScrollingUp = false;

  String _dir;

  Size _deviceSize;
  double _scrollPosition;

  final Map<int, GlobalKey> _widgetKeys = {};
  final Map<int, AnimationController> _videoControllers = {};

  double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData _selectedIcon;

  RatingController _ratingController = Get.find();

  int scrollPercent = 0;
  int total;
  int audioPlayed;

  int animation;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  bool audioPlaying = false;
  double position = 0.0;

  List<int> animationsId = [];
  List<String> audioIds = [];

  @override
  void initState() {
    super.initState();
    if (total == null) {
      total = (widget.total as MostVisitedResponse).totalVisits ?? 0;
      audioPlayed = (widget.total as MostVisitedResponse).audioPlayed ?? 0;
      animation = (widget.total as MostVisitedResponse).animation ?? 0;
    }

    _containsImageTransition =
        widget.story.items.any((item) => item is TransitionStoryImageItem);

    _dir = widget.dir;

    if (widget.userStoryReadCount == null) {
      _ratingController.setUserStoryCount(widget.story.storyId, 1);
    } else {
      _ratingController.setUserStoryCountUpdate(
          widget.story.storyId, widget.userStoryReadCount);
    }

    _scrollController.addListener(() {
      int percent = ((_scrollController.position.pixels /
                  _scrollController.position.maxScrollExtent) *
              100)
          .toInt();
      scrollPercent = percent;
      print("percent: $scrollPercent");
    });

    Map body = <String, dynamic>{
      "total_visits": total + 1,
      "story_name": widget.story.title,
      "audio_played": audioPlayed,
      "story_id": widget.story.storyId
    };
    _ratingController.setAnalytics("Story Page");
    _ratingController.setAnalytics("${widget.story.title}");
    String docId = "${widget.story.storyId}";
    _ratingController.setMostVisits(body: body, docId: docId);

    for (int index = 0; index < widget.story.items.length; index++) {
      if (widget.story.items[index].id != null) {
        _widgetKeys[widget.story.items[index].id] = GlobalKey();
      }
    }

    _containsVideo = widget.story.items.any((item) => item is StoryVideoItem);
    if (_containsVideo) {
      for (var item
          in widget.story.items.where((item) => item is StoryVideoItem)) {
        _videoControllers[item.id] = AnimationController(vsync: this);
      }
    }

    _containsAudio = (widget.story.audioItems ?? []).length > 0;
    if (_containsAudio) {
      _audioManager = new AudioManager();
    }

    print('contains audio: $_containsAudio');

    _downloadAssets().then((value) => {
          setState(() {
            _downloading = false;
          }),
        });
    Future.delayed(Duration(seconds: 2)).then((value) {
      _setup();

      AudioItem flag = widget.story.audioItems.firstWhere(
        (item) => item.asset == "assets/audio/sound_coover.mp3",
        orElse: () => null,
      );

      if (flag != null) {
        AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
        audioPlayer.open(
          Audio("assets/audio/sound_coover.mp3"),
          autoStart: true,
        );
        audioPlayer.play();
        Map body = <String, dynamic>{
          "total_visits": total + 1,
          "story_name": widget.story.title,
          "audio_played": audioPlayed + 1,
          "animation": animation,
          "story_id": widget.story.storyId
        };
        String docId = "${widget.story.storyId}";
        _ratingController.setMostVisits(body: body, docId: docId);
      }
    });

    resetTimer();
  }

  Color color;

  bool timer = false;

  void parseData(widget, Map<dynamic, dynamic> data) {
    (widget.story as Story)
        .items
        .add(StoryItem.fromJson(data as Map<String, dynamic>));
  }

  @override
  Widget build(BuildContext context) {
    /*  widget.story.items.clear();
    List<Map> list = [

    ];

    for (int index = 0; index < list.length; index++) {
      parseData(widget, list[index]);
    }*/

    _deviceSize = MediaQuery.of(context).size;
    if (!timer) {
      timer = true;
    }

    String colorString = widget.story.fontFamily ?? "";
    if (_initialRating == null) {
      _initialRating = double.parse((widget.storyRating ?? 0).toString());
    }
    bool hasColor = colorString.contains("#");
    if (hasColor) {
      color = HexColor.fromHex(colorString);
    }
    Future<bool> _willPopCallback() async {
      if (scrollPercent > 97) {
        showBottomSheet(context);
      } else {
        Map body = <String, dynamic>{
          "rating": _initialRating,
          "drop_percent": scrollPercent,
          "user_id": _ratingController.deviceId.value,
          "story_name": widget.story.title,
          "audio_played": audioPlayed,
          "animation": animation,
          "story_id": widget.story.storyId
        };
        String docId =
            "${widget.story.storyId}_${_ratingController.deviceId.value}";
        await _ratingController.rateStory(body: body, docId: docId);
        Get.back();
      }
      return false; // return true if the route to be popped
    }

    return Scaffold(
      backgroundColor: hasColor ? color : Colors.transparent,
      body: WillPopScope(
        onWillPop: _willPopCallback,
        child: _downloading
            ? Center(child: CircularProgressIndicator())
            : _renderStory(),
      ),
    );
  }

  Widget _renderStory() {
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: NotificationListener(
            onNotification: _handleScrollNotification,
            child: ListView(
              physics: _loading
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              padding: EdgeInsets.zero,
              children: [
                StoryCover(
                  widget.story,
                  onClose: _goBack,
                  isLoading: _loading,
                  image: getImage(
                    widget.story.coverImageAsset,
                    '$_dir/${widget.story.localDir}',
                    width: _deviceSize.width,
                    height: _deviceSize.height,
                    fit: BoxFit.fitHeight,
                  ),
                  title: widget.story.coverTitleAsset != null
                      ? getImage(
                          widget.story.coverTitleAsset,
                          '$_dir/${widget.story.localDir}',
                          width: _deviceSize.width * 0.7,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: SizeManager.of(context)
                        .transformY(widget.story.paddingTop),
                    bottom: SizeManager.of(context)
                        .transformY(widget.story.paddingBottom),
                    left: 0.0,
                    right: 0.0,
                  ),
                  color: _backgroundColor,
                  child: Column(
                    children: [
                      Column(
                        children: _mapItemsToWidgets(widget.story.items),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      MaterialButton(
                        onPressed: () {
                          showBottomSheet(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 6,
                            bottom: 6,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "Select Other Tale".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: SizeManager.of(context).transformX(24),
          top: SizeManager.of(context).transformY(80),
          child: _renderBackButton(),
        )
      ],
    );
  }

  Widget _renderBackButton() {
    // back button must be invisible on cover page
    bool isVisible = _isScrollingUp && _scrollPosition > _deviceSize.height;
    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: () => _goBack(),
        child: Lottie.asset(
          'assets/animated/story-back.json',
          width: SizeManager.of(context).transformX(86),
          repeat: false,
        ),
      ),
    );
  }

  List<Widget> _mapItemsToWidgets(List<StoryItem> items) {
    var deviceSize = MediaQuery.of(context).size;

    return items.map((item) {
      bool pinkShow = checkPinkShoe(items);
      if (item is StoryTextItem) {
        return pinkShow
            ? PinkShowStoryWdget(
                item: item,
              )
            : item.content.toString().contains("text_ype:")
                ? getText(item.content)
                : StoryText(
                    content: item.content,
                    color: HexColor.fromHex(item.color),
                    gap: item.gap != null
                        ? SizeManager.of(context).transformY(item.gap)
                        : 0.0,
                    align: item.align ?? TextAlign.left,
                    fontFamily: widget.story.fontFamily,
                    fontSize: widget.story.fontSize,
                    width: item.width,
                    textKey: item.id != null ? _widgetKeys[item.id] : null,
                  );
      } else if (item is StoryImageItem) {
        return StoryImage(
          image: getImage(
            item.asset,
            '$_dir/${widget.story.localDir}',
            width: deviceSize.width,
            fit: BoxFit.fitHeight,
            key: item.id != null ? _widgetKeys[item.id] : null,
          ),
          gap: item.gap != null
              ? SizeManager.of(context).transformY(item.gap)
              : 0.0,
          horizontalGap: item.horizontalGap != null
              ? SizeManager.of(context).transformY(item.horizontalGap)
              : 0.0,
        );
      } else if (item is TransitionStoryImageItem) {
        return TransitionStoryImage(
          firstImage: getImage(
            item.initialAsset,
            '$_dir/${widget.story.localDir}',
            width: deviceSize.width,
            fit: BoxFit.fitHeight,
            key: item.id != null ? _widgetKeys[item.id] : null,
          ),
          secondImage: getImage(
            item.finalAsset,
            '$_dir/${widget.story.localDir}',
            width: deviceSize.width,
            fit: BoxFit.fitHeight,
          ),
          gap: item.gap != null
              ? SizeManager.of(context).transformY(item.gap)
              : 0.0,
          horizontalGap: item.horizontalGap != null
              ? SizeManager.of(context).transformY(item.horizontalGap)
              : 0.0,
          position: item.position,
        );
      } else if (item is StoryVideoItem) {
        // var file =
        //     getLocalImageFile(item.asset, '$_dir/${widget.story.localDir}');

        String itemAssets = item.asset;
        if (itemAssets.contains("play_button")) {
          itemAssets = itemAssets.split("0_0")[0];
        }
        var file = getJsonFile(itemAssets, widget.story.localDir);
        return !hasPlayButton(item.asset)
            ? Container(
                padding: EdgeInsets.only(
                  top: item.gap,
                  left: item.horizontalGap,
                  right: item.horizontalGap,
                ),
                child: Lottie.file(
                  file,
                  key: item.id != null ? _widgetKeys[item.id] : null,
                  controller: _videoControllers[item.id],
                  repeat: true,
                  onLoaded: (composition) {
                    _videoControllers[item.id]..duration = composition.duration;
                  },
                ),
              )
            : Container(
                child: getWidgetView(file, item),
              );
      } else {
        return Container();
      }
    }).toList();
  }

  _setup() {
    for (var item in widget.story.backgroundTransitions) {
      GlobalKey key = _widgetKeys[item.itemRefId];
      if (key != null) {
        RenderBox box = key.currentContext.findRenderObject();
        double position = box.localToGlobal(Offset.zero).dy;
        print('Scroll Position: $position Item Size: ${box.size}');

        item.configure(position, _deviceSize.height, box.size.height);
      }
    }

    for (var item in widget.story.items
        .where((item) => item is TransitionStoryImageItem)) {
      var imageTransitionitem = item as TransitionStoryImageItem;
      GlobalKey key = _widgetKeys[item.id];
      if (key != null) {
        RenderBox box = key.currentContext.findRenderObject();
        double position = box.localToGlobal(Offset.zero).dy;
        print('Image Scroll Position: $position Item Size: ${box.size}');

        imageTransitionitem.startPosition =
            position - _deviceSize.height / 2 + box.size.height / 2;
        imageTransitionitem.durationInPixels =
            imageTransitionitem.duration * _deviceSize.height;
      }
    }

    for (var item
        in widget.story.items.where((item) => item is StoryVideoItem)) {
      var videoItem = item as StoryVideoItem;
      var position = _getPositionByElementId(item.id);
      print('Video Scroll Position: $position');

      videoItem.startPosition = position - _deviceSize.height / 2;
    }

    for (var item in widget.story.audioItems ?? []) {
      var startPosition = _getPositionByElementId(item.startItemRefId);
      var endPosition = _getPositionByElementId(
        item.endItemRefId,
        defaultValue: startPosition + _deviceSize.height,
      );

      item.startPosition = startPosition - _deviceSize.height / 2;
      // item.endPosition = (((item.startPosition / 22778 * 100) + 5) / 100) *
      //     _scrollController.position.maxScrollExtent;
      item.endPosition = item.startPosition + 250;
      print(
          'Audio start position: ${item.startPosition} end: ${item.endPosition}');
    }

    setState(() {
      _loading = false;
    });
  }

  double _getPositionByElementId(
    int itemId, {
    double defaultValue = 0,
  }) {
    GlobalKey key = _widgetKeys[itemId];
    if (key == null) {
      if (defaultValue != null) {
        return defaultValue;
      }
      throw 'No element found with id $itemId!';
    }
    RenderBox box = key.currentContext.findRenderObject();
    return box.localToGlobal(Offset.zero).dy;
  }

  bool _handleScrollNotification(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      _handleScrollDirectionChange(
          _scrollController.position.userScrollDirection);
      setState(() {
        _scrollPosition = _scrollController.position.extentBefore;
      });
      if (_containsImageTransition) {
        _handleImageTransitions(_scrollPosition);
      }
      if (_containsVideo) {
        _handleVideos(_scrollPosition);
      }
      _handleBackgroundTransitions(_scrollPosition);
      if (_containsAudio) {
        _handleAudio(_scrollPosition);
      }
    }
    return false;
  }

  _handleScrollDirectionChange(ScrollDirection direction) {
    setState(() {
      _isScrollingUp = direction == ScrollDirection.forward;
    });
  }

  _handleAudio(double scrollPosition) {
    AudioItem audio = widget.story.audioItems.firstWhere(
      (item) =>
          item.startPosition <= scrollPosition &&
          (item.startPosition + 250) >= scrollPosition,
      orElse: () => null,
    );

    if (audio != null) {
      if (audioPlayed == null) {
        audioPlayed = (widget.total as MostVisitedResponse).audioPlayed ?? 0;
      }
      bool exist = checkAnimationId(audioIds, audio.asset);
      if (!exist) {
        audioIds.add(audio.asset);
        print("$audioPlayed}");
        var pos = audio.startPosition + 500.0;
        position = pos;
        audioPlayer.stop();
        if (!audioPlaying) {
          audioPlaying = true;

          audioPlayed = audioPlayed + 1;

          Map body = <String, dynamic>{
            "audio_played": audioPlayed,
            "animation": animation + 1,
            "total_visits": total,
            "story_name": widget.story.title,
            "story_id": widget.story.storyId
          };
          String docId = "${widget.story.storyId}";
          _ratingController.setMostVisits(body: body, docId: docId);
          audioPlayer.open(
            Audio(audio.asset),
            autoStart: true,
          );
          audioPlayer.play();
        }
      }

      // audioPlaying = false;
      // _audioManager.play(audio);
    } else {
      // _audioManager.stop();
      // audioPlayer.stop();
    }
  }

  _handleVideos(double scrollPosition) {
    StoryVideoItem videoItems;

    for (var item
        in widget.story.items.where((item) => item is StoryVideoItem)) {
      StoryVideoItem videoItem = item as StoryVideoItem;

      if (videoItem.startPosition <= scrollPosition &&
          (videoItem.startPosition + 250) >= scrollPosition) {
        videoItems = videoItem;
        break;
      }
    }
    if (videoItems != null) {
      bool exist = checkAnimationId(animationsId, videoItems.id);
      if (!exist) {
        animationsId.add(videoItems.id);
        _handleVideo(
          scrollPosition,
          videoItems,
        );
      }
    }
  }

  _handleVideo(
    double position,
    StoryVideoItem item,
  ) async {
    var start = item.startPosition;
    var end = start + _deviceSize.height / 2;

    if (position >= start && position <= end) {
      // if (!exist) {
      // animationsId.add(item.id);
      _videoControllers[item.id].reset();
      _videoControllers[item.id].forward();
      // }
      // var transitionDuration = end - start;
      // var percent = (position - start) / transitionDuration;
      //
      // print("percent video $percent");
      // _videoControllers[item.id].value = percent;
    }
  }

  _handleImageTransitions(double scrollPosition) {
    for (var item in widget.story.items
        .where((item) => item is TransitionStoryImageItem)) {
      var imageTransitionItem = item as TransitionStoryImageItem;
      _handleImageTransition(
        scrollPosition,
        imageTransitionItem,
      );
    }
  }

  _handleImageTransition(
    double scrollPosition,
    TransitionStoryImageItem item,
  ) {
    var startTransitionPos = item.startPosition;
    var endTransitionPos = startTransitionPos + item.durationInPixels;

    if (scrollPosition < startTransitionPos) {
      if (item.position != 0.0) {
        setState(() {
          item.position = 0.0;
        });
      }
    } else if (scrollPosition >= startTransitionPos &&
        scrollPosition <= endTransitionPos) {
      var interpolation =
          (scrollPosition - startTransitionPos) / item.durationInPixels;
      setState(() {
        item.position = min(1.0, interpolation);
      });
    } else {
      if (item.position != 1.0) {
        setState(() {
          item.position = 1.0;
        });
      }
    }
  }

  _handleBackgroundTransitions(double scrollPosition) {
    Color color;
    bool insideAnyTransition = false;

    print("position $scrollPosition");
    for (var item in widget.story.backgroundTransitions) {
      bool isInsideTransition = _handleBackgroundTransition(
        scrollPosition,
        item.startPosition,
        item.durationInPixels,
        HexColor.fromHex(item.startColor),
        HexColor.fromHex(item.endColor),
      );

      insideAnyTransition = insideAnyTransition || isInsideTransition;

      if (color == null && scrollPosition < (item.startPosition ?? 0.0)) {
        color = HexColor.fromHex(item.startColor);
      }
    }

    if (!insideAnyTransition) {
      if (color == null) {
        color =
            HexColor.fromHex(widget.story.backgroundTransitions.last.endColor);
      }

      if (_backgroundColor != color) {
        setState(() {
          _backgroundColor = color;
        });
      }
    }
  }

  _handleBackgroundTransition(
    double scrollPosition,
    double transitionPosition,
    double duration,
    Color startColor,
    Color endColor,
  ) {
    bool isInsideTransition = false;

    var startTransitionPos = transitionPosition ?? 0.0;
    var endTransitionPos = startTransitionPos + (duration ?? 0.0);

    if (scrollPosition >= startTransitionPos &&
        scrollPosition <= endTransitionPos) {
      var interpolation = (scrollPosition - startTransitionPos) / duration;
      setState(() {
        _backgroundColor = Color.lerp(startColor, endColor, interpolation);
      });

      isInsideTransition = true;
    }

    return isInsideTransition;
  }

  void _goBack() {
    if (scrollPercent > 97) {
      showBottomSheet(context);
    } else {
      print('going back...');
      Navigator.of(context).pop();
    }
  }

  showBottomSheet(context) {
    showModal(context, initialRating: _initialRating, isVertical: _isVertical,
        onPickFile: (rating) async {
      print("$rating");
      setState(() {
        _rating = rating;
        _initialRating = rating;
      });
      Map body = <String, dynamic>{
        "rating": rating,
        "drop_percent": scrollPercent > 97 ? 100 : scrollPercent,
        "user_id": _ratingController.deviceId.value,
        "audio_played": audioPlayed,
        "animation": animation,
        "story_name": widget.story.title,
        "story_id": widget.story.storyId
      };
      String docId =
          "${widget.story.storyId}_${_ratingController.deviceId.value}";
      _ratingController.rateStory(
          body: body,
          docId: docId,
          onAdd: () {
            print("");
            Get.back();
            Get.back();
          });

      print("");
    });
  }

  Future<void> _downloadAssets() async {
    if (_dir == null) {
      _dir = (await getApplicationDocumentsDirectory()).path;
    }

    if (!await exists(widget.story.zipFileName, _dir)) {
      return;
    }
    // await _downloadZip(widget.story.assetPackageUrl, widget.story.zipFileName);
    var zippedFile = await downloadFile(
      '${widget.story.assetPackageUrl}',
      '${widget.story.zipFileName}',
      _dir,
    );

    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);

    var storyLocalDir = widget.story.localDir;

    for (var file in archive) {
      var filename = '$_dir/$storyLocalDir/${file.name}';
      if (file.isFile) {
        var outFile = File(filename);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  Future<File> _downloadFile(String url, String fileName) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$_dir/$fileName');
    if (req.statusCode == 503) {
      var data = await _downloadFile(url, fileName);
      return data;
    }
    return file.writeAsBytes(req.bodyBytes);
  }

  Future<void> _downloadZip(_zipPath, _localZipFileName) async {
    var zippedFile = await _downloadFile(_zipPath, _localZipFileName);
    await unarchiveAndSave(zippedFile);
  }

  Timer times;

  unarchiveAndSave(var zippedFile) async {
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = '$_dir/${widget.story.localDir}/${file.name}';
      if (file.isFile) {
        var outFile = File(fileName);
        //print('File:: ' + outFile.path);
        print("${outFile.path}");
        bool ex = await File(outFile.path).exists();
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
  }

  // void showModal(context, {onPickFile}) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           height: MediaQuery.of(context).size.height / 2.5,
  //           color: Color(0xff737373),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20),
  //                   topLeft: Radius.circular(20)),
  //             ),
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: 16,
  //                 ),
  //                 Center(
  //                   child: Container(
  //                     height: 4,
  //                     width: 50,
  //                     color: Colors.grey.shade200,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 40,
  //                 ),
  //                 Text(
  //                   "How was the tale?",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 32,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //                 SizedBox(
  //                   height: 40,
  //                 ),
  //                 RatingBar.builder(
  //                   initialRating: _initialRating,
  //                   minRating: 1,
  //                   direction: _isVertical ? Axis.vertical : Axis.horizontal,
  //                   allowHalfRating: false,
  //                   unratedColor: Colors.amber.withAlpha(50),
  //                   itemCount: 5,
  //                   itemSize: 50.0,
  //                   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
  //                   itemBuilder: (context, _) => Icon(
  //                     _selectedIcon ?? Icons.star,
  //                     color: Colors.amber,
  //                   ),
  //                   onRatingUpdate: (rating) async {
  //                     print("$rating");
  //                     setState(() {
  //                       _rating = rating;
  //                       _initialRating = rating;
  //                     });
  //                     Map body = <String, dynamic>{
  //                       "rating": rating,
  //                       "drop_percent":
  //                           scrollPercent > 97 ? 100 : scrollPercent,
  //                       "user_id": _ratingController.deviceId.value,
  //                       "audio_played": audioPlayed,
  //                       "story_name": widget.story.title,
  //                       "story_id": widget.story.storyId
  //                     };
  //                     String docId =
  //                         "${widget.story.storyId}_${_ratingController.deviceId.value}";
  //                     _ratingController.rateStory(
  //                         body: body,
  //                         docId: docId,
  //                         onAdd: () {
  //                           print("");
  //                           Get.back();
  //                           Get.back();
  //                         });
  //
  //                     print("");
  //                   },
  //                   updateOnDrag: true,
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  int timerCount = 0;

  @override
  void dispose() {
    if (_videoControllers != null) {
      for (var controller in _videoControllers.values) {
        controller.dispose();
      }
    }

    if (_audioManager != null) {
      _audioManager.dispose();
    }

    if (audioPlayer != null) {
      audioPlayer.stop();
    }

    if (times != null) {
      times.cancel();
    }
    super.dispose();
  }

  void resetTimer() {
    timerCount = timerCount + 1;
    print("Timer count $timerCount");
    times = Timer.periodic(Duration(seconds: 4), (timer) {
      audioPlaying = false;
      // resetTimer();
      if (_scrollPosition != null) {
        if (_scrollPosition > 85) {
          animationsId.clear();
          audioIds.clear();
        }
      }
    });
  }

  getJsonFile(String asset, set) {
    ///data/user/0/com.example.horror_story/app_flutter/voodoo/voodoo-cover.png
    ///
    String dir = '$_dir/${widget.story.localDir}/$asset';

    File file = File(dir);
    print("${file.exists()}");

    // return "assets/$set/$asset";
    return file;
  }

  hasPlayButton(String asset) {
    if (asset.contains("0_0play_button")) {
      return true;
    }
    return false;
  }

  playButton({width, height, widthPlay, heightPlay, onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Column(
        children: [
          Container(
            width: double.parse((width ?? 100).toString()),
            height: double.parse((height ?? 100).toString()),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/img_play_btn_bg.png'),
                Image.asset(
                  'assets/images/img_play_arrow.png',
                  width: double.parse((widthPlay ?? 24).toString()),
                  height: double.parse((heightPlay ?? 24).toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getAudio(int id, List<AudioItem> audioItems) {
    for (int index = 0; index < audioItems.length; index++) {
      if (audioItems[index].startItemRefId.toString() == id.toString()) {
        return audioItems[index].asset;
      }
    }
    return "";
  }

  getWidgetView(file, item) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(
          top: SizeManager.of(context).transformY(100),
          bottom: SizeManager.of(context).transformY(50),
          left: SizeManager.of(context).transformY(75),
          right: SizeManager.of(context).transformY(75)),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Lottie.file(
            file,
            fit: BoxFit.fitWidth,
            key: item.id != null ? _widgetKeys[item.id] : null,
            controller: _videoControllers[item.id],
            onLoaded: (composition) {
              _videoControllers[item.id]..duration = composition.duration;
            },
          ),
          Container(
            width: Get.width,
            alignment: Alignment.topRight,
            child: playButton(
                width: 72,
                widthPlay: 18,
                heightPlay: 18,
                onTap: () {
                  var audio = getAudio(item.id, widget.story.audioItems);
                  var path = '$_dir/${widget.story.localDir}' + "/" + audio;
                  if (audio.toString().isNotEmpty) {
                    audioPlayer.open(
                      Audio(audio),
                      autoStart: true,
                    );
                    audioPlayer.play();
                    _videoControllers[item.id].reset();
                    _videoControllers[item.id].forward();
                    Map body = <String, dynamic>{
                      "audio_played": audioPlayed + 1,
                      "animation": animation,
                      "total_visits": total,
                      "story_name": widget.story.title,
                      "story_id": widget.story.storyId
                    };

                    String docId = "${widget.story.storyId}";
                    _ratingController.setMostVisits(body: body, docId: docId);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget getText(String content) {
    if (content.toString().contains("text_ype:baloon:")) {
      List contents = content.split("0-0");
      return Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        child: Stack(
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.only(left: 80, right: 80),
              child: Text(
                "${contents[0]}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
            ),
            Container(
              width: Get.width,
              height: 140,
              margin: EdgeInsets.only(left: 70, right: 70, top: 134),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: 100,
                    height: 140,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/img_baloons.png'),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 90, top: 250),
              padding: EdgeInsets.only(left: 12, right: 12, top: 4),
              width: Get.width,
              height: 40,
              child: Text(
                "${contents[1].toString().replaceAll("text_ype:baloon:", "")}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  color: Color(0xffFCFAD6),
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_bar_one.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 80, top: 294),
              padding: EdgeInsets.only(left: 12, right: 12, top: 4),
              width: Get.width,
              height: 40,
              child: Text(
                "${contents[2].toString()}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  color: Color(0xffFCFAD6),
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_bar_two.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 160, top: 340),
              padding: EdgeInsets.only(left: 12, right: 12, top: 4),
              width: Get.width,
              height: 40,
              child: Text(
                "${contents[3].toString()}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  color: Color(0xffFCFAD6),
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_bar_three.png'),
                      fit: BoxFit.fill)),
            ),
          ],
        ),
      );
    }
    if (content.toString().contains("text_ype:middle:")) {
      List contents = content.split("0-0");
      return Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 70, right: 90, top: 60),
              padding: EdgeInsets.only(left: 12, right: 12, top: 4),
              width: Get.width,
              height: 40,
              child: Text(
                "${contents[0].toString().replaceAll("text_ype:middle:", "")}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  color: Color(0xffFCFAD6),
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_bar_4.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 120, top: 104),
              padding: EdgeInsets.only(left: 12, right: 12, top: 0),
              width: Get.width,
              height: 40,
              child: Text(
                "${contents[1].toString()}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  color: Color(0xffFCFAD6),
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_bar_five.png'),
                      fit: BoxFit.fill)),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 0, top: 148),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 12, right: 12, top: 0),
                    width: 100,
                    height: 40,
                    child: Text(
                      "${contents[2].toString()}",
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Color(0xffFCFAD6),
                        fontSize: SizeManager.of(context)
                            .transformX(widget.story.fontSize),
                      ),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/img_bar_six.png'),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    child: Text(
                      "${contents[3]}",
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Colors.black,
                        fontSize: SizeManager.of(context)
                            .transformX(widget.story.fontSize),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (content.toString().contains("text_ype:hear:")) {
      List contents = content.split("0-0");
      return Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 70, right: 0, top: 0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    child: Text(
                      "${contents[0].toString().replaceAll("text_ype:hear:", "")}",
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Colors.black,
                        fontSize: SizeManager.of(context)
                            .transformX(widget.story.fontSize),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 0, right: 90, top: 0),
                    padding: EdgeInsets.only(left: 12, right: 12, top: 0),
                    width: 100,
                    height: 40,
                    child: Text(
                      "${contents[1].toString()}",
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Color(0xffFCFAD6),
                        fontSize: SizeManager.of(context)
                            .transformX(widget.story.fontSize),
                      ),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/img_bar_seven.png'),
                            fit: BoxFit.fill)),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 70, right: 150, top: 45),
              padding: EdgeInsets.only(left: 12, right: 12, top: 4),
              width: Get.width,
              height: 40,
              child: Text(
                "${contents[2]}",
                style: GoogleFonts.comicNeue(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  color: Color(0xffFCFAD6),
                  fontSize:
                      SizeManager.of(context).transformX(widget.story.fontSize),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_bar_eight.png'),
                      fit: BoxFit.fill)),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 70, right: 0, top: 81),
                  padding: EdgeInsets.only(left: 12, right: 12, top: 0),
                  width: 115,
                  height: 40,
                  child: Text("${contents[3].toString()}",
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: Color(0xffFCFAD6),
                        fontSize: SizeManager.of(context)
                            .transformX(widget.story.fontSize),
                      )),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/img_bar_nine.png'),
                          fit: BoxFit.fill)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 0, right: 0, top: 81),
                  padding: EdgeInsets.only(left: 0, right: 12, top: 0),
                  width: 100,
                  height: 40,
                  child: Text("${contents[4].toString()}",
                      style: GoogleFonts.comicNeue(
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                        color: Colors.black,
                        fontSize: SizeManager.of(context)
                            .transformX(widget.story.fontSize),
                      )),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 75, right: 75, top: 115),
              width: Get.width,
              child: Text("${contents[5].toString()}",
                  style: GoogleFonts.comicNeue(
                    fontWeight: FontWeight.w900,
                    height: 1.5,
                    color: Colors.black,
                    fontSize: SizeManager.of(context)
                        .transformX(widget.story.fontSize),
                  )),
            ),
            Container(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 20, right: 40),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img_heart.png'),
                              fit: BoxFit.fill)),
                    ),
                  ],
                ))
          ],
        ),
      );
    }

    /*
    TextStyle(
            color: Colors.black,
            fontSize: SizeManager.of(context)
                .transformX(widget.story.fontSize),
            height: 1.5)
     */

    return Container(
        margin: EdgeInsets.only(left: 75, right: 75, top: 50),
        child: Text(
          "${content.toString().replaceAll("text_ype:", "")}",
          style: GoogleFonts.comicNeue(
            fontWeight: FontWeight.w900,
            height: 1.5,
            fontSize: SizeManager.of(context).transformX(widget.story.fontSize),
          ),
        ));
  }

  bool checkPinkShoe(List<StoryItem> item) {
    for (int index = 0; index < item.length; index++) {
      if (item[index] is StoryTextItem) {
        StoryTextItem it = item[index];
        if (it.content.toString().toLowerCase().contains("bar_text")) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkAnimationId(animations, id) {
    for (int index = 0; index < animations.length; index++) {
      if (animations[index] == id) {
        return true;
      }
    }
    return false;
  }
}
