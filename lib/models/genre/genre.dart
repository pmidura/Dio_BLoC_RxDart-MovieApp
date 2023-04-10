import 'package:equatable/equatable.dart';

class Genre extends Equatable{
  final int id;
  final String name;

  const Genre({
    required this.id,
    required this.name,
  });

  Genre.fromJson(Map<String, dynamic> json) :
    id = json["id"] ?? 0,
    name = json["name"] ?? "";

  @override
  List<Object?> get props => [id, name];

  static const empty = Genre(id: 0, name: "");
}
