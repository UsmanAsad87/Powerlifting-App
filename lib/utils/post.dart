import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String userId;
  int programId;
  String? name;

  Post({
    required this.name,
    required this.userId,
    required this.programId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      name: json["name"], userId: json["userId"], programId: json["programId"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "userId": userId, "programId": programId};
}
