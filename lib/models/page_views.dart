class PageViews {
  int about;
  int cataLogPage;
  int contact;
  int homePage;
  int menuPage;
  int settings;
  int support;

  PageViews(
      {this.about,
      this.cataLogPage,
      this.contact,
      this.homePage,
      this.menuPage,
      this.settings,
      this.support});

  PageViews.fromJson(dynamic json) {
    about = json["About Us"];
    cataLogPage = json["CataLogPage"];
    contact = json["Contact"];
    homePage = json["HomePage"];
    menuPage = json["MenuPage"];
    settings = json["Settings"];
    support = json["Support"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["About Us"] = about;
    map["CataLogPage"] = cataLogPage;
    map["Contact"] = contact;
    map["HomePage"] = homePage;
    map["MenuPage"] = menuPage;
    map["Settings"] = settings;
    map["Support"] = support;
    return map;
  }
}
