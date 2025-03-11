import 'package:course_app/video/video_model.dart';
import 'package:course_app/video/video_repo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

class VideoUpload extends StatefulWidget {
  const VideoUpload({Key? key}) : super(key: key);

  @override
  State<VideoUpload> createState() => _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  final VideoRepository videoRepository = VideoRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? _videoPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload de Vídeo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Título do Vídeo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Descrição do Vídeo",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            if (_videoPath != null)
              VTImageView(
                videoUrl: _videoPath!,
                width: double.infinity,
                height: 150,
                assetPlaceHolder: "assets/transparent.png",
                errorBuilder: (context, error, stack) {
                  return Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text(
                      "Erro ao carregar thumbnail",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _videoPath == null ? _selectVideo : _uploadVideo,
              child: Text(_videoPath == null ? "Selecionar Vídeo" : "Enviar Vídeo"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _videoPath = result.files.single.path!;
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, preencha o título e a descrição."),
        ),
      );
      return;
    }

    if (_videoPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione um vídeo."),
        ),
      );
      return;
    }

    VideoModel video = VideoModel(
      title: titleController.text,
      description: descriptionController.text,
      videoPath: _videoPath!,
    );

    await videoRepository.uploadVideo(video);

    setState(() {
      titleController.clear();
      descriptionController.clear();
      _videoPath = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Vídeo enviado com sucesso!"),
      ),
    );
  }
}
