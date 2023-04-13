// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.modelName,
    required this.modelMakeId,
  });

  String modelName;
  String modelMakeId;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    modelName: json["model_name"],
    modelMakeId: json["model_make_id"],
  );

  Map<String, dynamic> toJson() => {
    "model_name": modelName,
    "model_make_id": modelMakeId,
  };
}
