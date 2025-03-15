class VideoModel {
  final String title;
  final String description;
  final String? videoPath;

  VideoModel({
    required this.title,
    required this.description,
    this.videoPath,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
    };
  }
}
