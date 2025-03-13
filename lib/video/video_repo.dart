import 'dart:convert';
import 'dart:io';
import 'package:course_app/api_path.dart';
import 'package:course_app/video/video_model.dart';
import 'package:http/http.dart' as http;

class VideoRepository {
 Future<void> uploadVideo(Video video) async {
  try {
    var uri = Uri.parse("$apiPath/v1/video");
    var request = http.MultipartRequest("POST", uri);

    request.fields["title"] = video.title ?? '';
    request.fields["description"] = video.description ?? '';

    if (video.url != null) {
      var file = File(video.url!);
      if (await file.exists()) {
        request.files.add(
          await http.MultipartFile.fromPath("video", file.path),
        );
      }
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Falha no upload: $responseBody");
    }
  } catch (e) {
    print("Erro no upload: $e");
    rethrow;
  }
}

  Future<VideoGet?> getVideos() async {
    try {
      final response = await http.get(Uri.parse("$apiPath/v1/video"));
      
      if (response.statusCode == 200) {
        return VideoGet.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print('Erro ao buscar vídeos: $e');
      return null;
    }
  }

  Future<Video?> getVideoById(String id) async {
    try {
      final response = await http.get(Uri.parse("$apiPath/v1/video/$id"));
      
      if (response.statusCode != 200) return null;
      
      final jsonData = jsonDecode(response.body);
      
      if (jsonData['video'] == null) return null;
      
      return Video.fromJson(jsonData['video']);
    } catch (e) {
      print('Erro ao buscar vídeo: $e');
      return null;
    }
  }
}