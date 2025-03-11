import 'dart:io';
import 'package:course_app/api_path.dart';
import 'package:http/http.dart' as http;
import 'video_model.dart';

class VideoRepository {

  Future<void> uploadVideo(VideoModel video) async {
    try {
      var uri = Uri.parse("$apiPath/v1/video");
      var request = http.MultipartRequest("POST", uri);

      request.fields["title"] = video.title;
      request.fields["description"] = video.description;

      if (video.videoPath != null) {
        var file = File(video.videoPath!);
        request.files.add(
          await http.MultipartFile.fromPath("video", file.path),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Vídeo enviado com sucesso!");
      } else {
        print("Erro no upload: ${response.statusCode}, ${responseBody}");
      }
    } catch (e) {
      print("Erro ao enviar vídeo: $e");
    }
  }
}
