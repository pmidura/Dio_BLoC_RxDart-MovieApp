import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
  
  const Person({
    required this.id,
    required this.popularity,
    required this.name,
    required this.profileImg,
    required this.known,
  });

  Person.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? 0,
    popularity = json["popularity"] ?? 0.0,
    name = json["name"] ?? "",
    profileImg = json["profile_path"] ?? "",
    known = json["known_for_department"] ?? "";

  @override
  List<Object?> get props => [id, popularity, name, profileImg, known];

  static const empty = Person(id: 0, popularity: 0.0, name: "", profileImg: "", known: "");
}
