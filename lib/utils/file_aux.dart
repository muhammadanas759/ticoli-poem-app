import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

Future<bool> exists(String name, String dir) async {
  var file = File('$dir/$name');
  return !(await file.exists());
}

Future<File> downloadFile(String url, String filename, String dir) async {
  var req = await http.Client().get(Uri.parse(url));
  var file = File('$dir/$filename');
  if (req.statusCode == 503) {
    var data = await downloadFile(url, filename, dir);
    return data;
  }
  return file.writeAsBytes(req.bodyBytes);
}

Widget getImage(
  String name,
  String directory, {
  double width,
  double height,
  BoxFit fit,
  Key key,
}) {
  var file = getLocalImageFile(name, directory);
  bool flag = file.path.contains("svg");
  Future.delayed(Duration(seconds: 0)).then((value) async {
    var ex = await file.exists();
    print("$ex");

    return flag
        ? SvgPicture.file(
            file,
            key: key,
            width: width,
            height: height,
            fit: fit,
          )
        : Image.file(
            file,
            key: key,
            width: width,
            height: height,
            fit: fit,
          );
  });
  return flag
      ? SvgPicture.file(
          file,
          key: key,
          width: width,
          height: height,
          fit: fit,
        )
      : Image.file(
          file,
          key: key,
          width: width,
          height: height,
          fit: fit,
        );
}

File getLocalImageFile(String name, String dir) => File('$dir/$name');
