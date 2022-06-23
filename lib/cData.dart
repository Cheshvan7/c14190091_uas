class cData {
  String link;
  String title;
  String pubDate;
  String description;
  String thumbnail;

  cData({
    required this.link,
    required this.title,
    required this.pubDate,
    required this.description,
    required this.thumbnail,
  });

  factory cData.fromJson(Map<String, dynamic> json) {
    return cData(link: json['link'], title: json['title'], pubDate: json['pubDate'], description: json['description'], thumbnail: json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    return {
      "link": link,
      "title": title,
      "pubDate": pubDate,
      "description": description,
      "thumbnail": thumbnail,
    };
  }
}