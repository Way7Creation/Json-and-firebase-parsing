class AlbumsUsers {
  int userId;
  int id;
  String title;

  AlbumsUsers({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumsUsers.fromJson(Map<String, dynamic> json) => AlbumsUsers(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
  };
}




