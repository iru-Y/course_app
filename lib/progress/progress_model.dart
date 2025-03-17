class Video {
  final String? id;
  final String? title;
  final String? description;
  final String? url;

  Video({
    this.id,
    this.title,
    this.description,
    this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'url': url,
    };
  }
}

class Module {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? videoIds;
  final String? introVideoId;

  Module({
    this.id,
    this.title,
    this.description,
    this.videoIds,
    this.introVideoId,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      videoIds: json['videos'] != null ? List<String>.from(json['videos']) : null,
      introVideoId: json['introVideo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'videos': videoIds,
      'introVideo': introVideoId,
    };
  }
}

class Progress {
  final String? id;
  final String? courseId;
  final String? userId;
  final List<Module>? completedModules;
  final List<Video>? completedVideos;
  final DateTime? lastAccessedAt;

  Progress({
    this.id,
    this.courseId,
    this.userId,
    this.completedModules,
    this.completedVideos,
    this.lastAccessedAt,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['_id'],
      courseId: json['course'],
      userId: json['user'],
      completedModules: json['completedModule'] != null
          ? (json['completedModule'] as List)
              .map((module) => Module.fromJson(module))
              .toList()
          : null,
      completedVideos: json['completedVideos'] != null
          ? (json['completedVideos'] as List)
              .map((video) => Video.fromJson(video))
              .toList()
          : null,
      lastAccessedAt: json['lastAccessedAt'] != null
          ? DateTime.parse(json['lastAccessedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'course': courseId,
      'user': userId,
      'completedModule': completedModules?.map((module) => module.toJson()).toList(),
      'completedVideos': completedVideos?.map((video) => video.toJson()).toList(),
      'lastAccessedAt': lastAccessedAt?.toIso8601String(),
    };
  }
}

class ProgressResponse {
  final String? message;
  final Progress? progress;

  ProgressResponse({
    this.message,
    this.progress,
  });

  factory ProgressResponse.fromJson(Map<String, dynamic> json) {
    return ProgressResponse(
      message: json['message'],
      progress: json['progress'] != null ? Progress.fromJson(json['progress']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'progress': progress?.toJson(),
    };
  }
}
