import 'video.dart';

class VideoResponse {
  final List<Video> videos;
  final String error;

  VideoResponse({
    required this.videos,
    required this.error,
  });

  VideoResponse.fromJson(Map<String, dynamic> json) :
    videos = (json["results"] as List).map((e) => Video.fromJson(e)).toList(),
    error = "";

  VideoResponse.withError(String errorVal) :
    videos = [],
    error = errorVal;
}
