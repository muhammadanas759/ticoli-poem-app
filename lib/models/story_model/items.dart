class Items {
  String content;
  String color;
  int width;

  Items({
      this.content, 
      this.color, 
      this.width});

  Items.fromJson(dynamic json) {
    content = json["content"];
    color = json["color"];
    width = json["width"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["content"] = content;
    map["color"] = color;
    map["width"] = width;
    return map;
  }

}