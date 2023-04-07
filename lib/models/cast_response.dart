import 'cast.dart';

class CastResponse {
  final List<Cast> casts;
  final String error;

  CastResponse({
    required this.casts,
    required this.error,
  });

  CastResponse.fromJson(Map<String, dynamic> json) :
    casts = (json["cast"] as List).map((e) => Cast.fromJson(e)).toList(),
    error = "";

  CastResponse.withError(String errorVal) :
    casts = [],
    error = errorVal;
}
