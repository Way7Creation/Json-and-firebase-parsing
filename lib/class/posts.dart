class PostUsers {
  int userId;
  int id;
  String title;
  String body;

  PostUsers({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostUsers.fromJson(Map<String, dynamic> json) => PostUsers(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
