import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horror_story/models/story_text_item.dart';

class PinkShowStoryWdget extends StatefulWidget {
  StoryTextItem item;

  PinkShowStoryWdget({Key key, this.item}) : super(key: key);

  @override
  _PinkShowStoryWdgetState createState() => _PinkShowStoryWdgetState();
}

class _PinkShowStoryWdgetState extends State<PinkShowStoryWdget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: getText(widget.item),
    );
  }

  getText(StoryTextItem item) {
    if (item.content.toString().contains("bar_text:one")) {
      return getBarTextOne(item.content);
    } else if (item.content.toString().contains("harry:")) {
      return createHarryAndGirls(
          label: "Harry",
          image: 'assets/gwaps/img_harry.png',
          content: item.content.toString().replaceAll("harry:", ""));
    } else if (item.content.toString().contains("tommy:")) {
      return createTommy(
          label: "Tommy",
          content: item.content.toString().replaceAll("tommy:", ""));
    } else if (item.content.toString().contains("bar_text:two")) {
      return getBarTextTwo(item.content);
    } else if (item.content.toString().contains("bar_text_three")) {
      return getBarTextThree(item.content);
    } else if (item.content.toString().contains("bar_text_four")) {
      return getBarTextFour(item.content);
    } else if (item.content.toString().contains("bar_text_five")) {
      return getBarTextFive(item.content);
    } else if (item.content.toString().contains("bar_text_six")) {
      return getBarTextSix(item.content);
    } else if (item.content.toString().contains("bar_text_seven")) {
      return getBarTextSeven(item.content);
    } else if (item.content.toString().contains("girl:")) {
      return createHarryAndGirls(
          label: "Harry",
          image: 'assets/gwaps/img_pink_girl.png',
          content: item.content.toString().replaceAll("girl:", ""));
    }

    return Container(
      margin: EdgeInsets.only(left: 75, right: 75, top: 40, bottom: 40),
      child: Text(
        "${widget.item.content.replaceAll("simple:", "")}",
        style: GoogleFonts.comicNeue(fontSize: 18, fontWeight: FontWeight.w900),
      ),
    );
  }

  getBarTextOne(String content) {
    List list = content.split("0-0");
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 135, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_one.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text:one:", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 75, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_one_b.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 95, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_one_c.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[2].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 75, top: 24),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_one_d.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[3].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 115, top: 2),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_one_e.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[4].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 0, right: 65, top: 0),
          height: 70,
          width: 70,
          child: Image.asset(
            'assets/gwaps/bar_text_one_h.png',
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }

  createHarryAndGirls({label, content, image}) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 25, top: 40),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 90,
                child: Image.asset(
                  image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Container(
            width: Get.width,
            margin: EdgeInsets.only(top: 40, left: 95, right: 40),
            padding: EdgeInsets.only(top: 12, left: 44, right: 40, bottom: 24),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/gwaps/img_bg_sender.png'),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label",
                  style: GoogleFonts.comicNeue(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400]),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "$content",
                  style: GoogleFonts.comicNeue(
                      fontSize: 18, fontWeight: FontWeight.w900),
                )
              ],
            ))
      ],
    );
  }

  createTommy({label, content}) {
    return Stack(
      children: [
        Container(
            width: Get.width,
            margin: EdgeInsets.only(top: 12, left: 40, right: 95),
            padding: EdgeInsets.only(top: 12, left: 24, right: 40, bottom: 24),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/gwaps/img_bg_receiver.png'),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label",
                  style: GoogleFonts.comicNeue(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400]),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "$content",
                  style: GoogleFonts.comicNeue(
                      fontSize: 18, fontWeight: FontWeight.w900),
                )
              ],
            )),
        Container(
          margin: EdgeInsets.only(left: Get.width - 115, top: 20),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 90,
                child: Image.asset(
                  'assets/gwaps/img_tommy.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getBarTextTwo(String content) {
    List list = content.split("0-0");
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 105, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_two_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text:two:", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 75, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_two_b.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 95, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_two_c.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[2].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 75, top: 0),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_one_d.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[3].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 85, top: 2),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_two_e.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[4].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 165, top: 2),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_two_e.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[5].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: Get.width - 125, top: 250),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/gwaps/bar_text_one_g.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getBarTextThree(String content) {
    List list = content.split("0-0");
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 75, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text_three:", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 75, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_b.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 95, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_c.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[2].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 185, top: 0),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_e.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[3].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 85, top: 24),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_f.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[4].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 115, top: 2),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_f.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[5].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 145, top: 2),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_three_f.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[6].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      ],
    );
  }

  getBarTextFour(String content) {
    List list = content.split("0-0");
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 125, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_four_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text_four:", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 120, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_four_b.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 235, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_four_c.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[2].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 85, top: 24),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_four_d.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[3].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: 100,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 85, top: 4),
              padding: EdgeInsets.only(left: 12, right: 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_four_d.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[4].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ],
    );
  }

  getBarTextFive(String content) {
    List list = content.split("0-0");
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 95, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_five_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text_five:", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 120, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_five_b.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 89, top: 24),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_five_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[2].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: 120,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 85, top: 4),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_four_d.png"),
                    fit: BoxFit.fill),
              ),
              child: Text(
                "${list[3].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ],
    );
  }

  getBarTextSix(String content) {
    List list = content.split("0-0");
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 125, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_five_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text_six", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 100, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_five_b.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ],
    );
  }

  getBarTextSeven(String content) {
    List list = content.split("0-0");
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 125, top: 50),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/gwaps/bar_text_five_a.png"),
                    fit: BoxFit.cover),
              ),
              child: Text(
                "${list[0].toString().replaceAll("bar_text_seven:", "")}",
                style: GoogleFonts.comicNeue(
                    fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(left: 75, right: 100, top: 2),
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                "${list[1].toString()}",
                style: GoogleFonts.comicNeue(
                    color: Colors.grey.shade500,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
