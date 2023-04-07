class Cast {
  final int id;
  final String character;
  final String name;
  final String img;

  Cast({
    required this.id,
    required this.character,
    required this.name,
    required this.img,
  });

  Cast.fromJson(Map<String, dynamic> json) :
    id = json["cast_id"],
    character = json["character"],
    name = json["name"],
    img = json["profile_path"];
}
