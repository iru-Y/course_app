class VideoGet {
  final String? message;
  final List<Video>? videos;

  VideoGet({this.message, this.videos});

  factory VideoGet.fromJson(Map<String, dynamic> json) {
    return VideoGet(
      message: json['message'],
      videos: (json['video'] as List<dynamic>?)
          ?.map((v) => Video.fromJson(v))
          .toList(),
    );
  }
}

class Video {
  final String? sId;
  final String? title;
  final String? description;
  final String? url;

  Video({this.sId, this.title, this.description, this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      sId: json['_id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'title': title,
        'description': description,
        'url': url,
      };
}