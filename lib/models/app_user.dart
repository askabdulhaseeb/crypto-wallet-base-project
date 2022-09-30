import 'dart:convert';

class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
  });

  final String uid;
  final String name;
  final String email;

  final String imageURL;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,

      // 'imageURL': imageURL,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['data']['uid'] ?? '',
      name: map['data']['name'] ?? '',
      email: map['data']['email'] ?? '',
      imageURL: map['data']['imageURL'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // ignore: sort_constructors_first
  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));
}
