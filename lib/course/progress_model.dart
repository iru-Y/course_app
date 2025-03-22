// progress_model.dart
// progress_model.dart
class ProgressResponse {
  final String message;
  final ProgressModel progress;

  ProgressResponse({
    required this.message,
    required this.progress,
  });

  factory ProgressResponse.fromJson(Map<String, dynamic> json) {
    return ProgressResponse(
      message: json['message'],
      progress: ProgressModel.fromJson(json['progress']),
    );
  }
}

class ProgressModel {
  final String id;
  final String courseId;
  final String userId;
  final List<CompletedModule> completedModules;
  final List<CompletedVideo> completedVideos;
  final DateTime lastAccessedAt;

  ProgressModel({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.completedModules,
    required this.completedVideos,
    required this.lastAccessedAt,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['_id'],
      courseId: json['course'],
      userId: json['user'],
      completedModules: (json['completedModule'] as List)
          .map((module) => CompletedModule.fromJson(module))
          .toList(),
      completedVideos: (json['completedVideos'] as List)
          .map((video) => CompletedVideo.fromJson(video))
          .toList(),
      lastAccessedAt: DateTime.parse(json['lastAccessedAt']),
    );
  }
}

// ... (CompletedModule e CompletedVideo permanecem iguais)

// --------------------------------------------------
class CompletedModule {
  final String id;
  final String title;
  final String description;
  final List<String> videos;
  final String introVideo;

  CompletedModule({
    required this.id,
    required this.title,
    required this.description,
    required this.videos,
    required this.introVideo,
  });

  factory CompletedModule.fromJson(Map<String, dynamic> json) {
    return CompletedModule(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      videos: (json['videos'] as List).cast<String>(),
      introVideo: json['introVideo'],
    );
  }
}

// --------------------------------------------------
class CompletedVideo {
  final String id;
  final String title;
  final String description;
  final String url;

  CompletedVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
  });

  factory CompletedVideo.fromJson(Map<String, dynamic> json) {
    return CompletedVideo(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
    );
  }
}