class PostEntity {
  String title;
  String body;

  PostEntity({
    required this.title,
    required this.body,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) => PostEntity(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}
