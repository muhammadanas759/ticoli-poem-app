import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horror_story/utils/size_manager.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeManager.of(context).transformX(30),
        left: SizeManager.of(context).transformX(60),
        right: SizeManager.of(context).transformX(60),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "This is what we have so far, to keep",
            style: GoogleFonts.lato(
              color: Color(0xff686868),
              fontSize: SizeManager.of(context).transformX(34),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "update on our upcoming content.",
            style: GoogleFonts.lato(
              color: Color(0xff686868),
              fontSize: SizeManager.of(context).transformX(34),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Turn On Notification!",
            style: GoogleFonts.lato(
              color: Color(0xff686868),
              fontSize: SizeManager.of(context).transformX(34),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 24, right: 24),
            decoration: BoxDecoration(
                color: Color(0xffF13A5E),
                borderRadius: BorderRadius.circular(28)),
            child: Text(
              "KEEP UPDATED",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: SizeManager.of(context).transformX(28),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(),
          SizedBox(
            height: 8,
          ),
          Text(
            "The copyright of this content belongs to",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: SizeManager.of(context).transformX(28),
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "the author or the provider, and any",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: SizeManager.of(context).transformX(28),
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "unauthorized use may be liable according",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: SizeManager.of(context).transformX(28),
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            "to copyrights laws.",
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: SizeManager.of(context).transformX(28),
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
