import 'package:equatable/equatable.dart';

class Cast extends Equatable {
  final int id;
  final String character;
  final String name;
  final String img;

  const Cast({
    required this.id,
    required this.character,
    required this.name,
    required this.img,
  });

  Cast.fromJson(Map<String, dynamic> json) :
    id = json["cast_id"] ?? 0,
    character = json["character"] ?? "",
    name = json["name"] ?? "",
    img = json["profile_path"] ?? "";

  @override
  List<Object?> get props => [id, character, name, img];

  static const empty = Cast(id: 0, character: "", name: "", img: "");
}
