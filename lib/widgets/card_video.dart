import 'dart:math';
import 'package:course_app/app_routes.dart';
import 'package:course_app/video/video_model.dart';
import 'package:course_app/video/video_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCardVideo extends StatelessWidget {
  const ShowCardVideo({super.key});

  LinearGradient _randomGradient() {
    final Random random = Random();
    Color baseColor = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    Color darkerColor = Color.fromARGB(
      255,
      (baseColor.red * 0.7).toInt(),
      (baseColor.green * 0.7).toInt(),
      (baseColor.blue * 0.7).toInt(),
    );
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [baseColor, darkerColor],
    );
  }

  @override
  Widget build(BuildContext context) {
    final videoRepository = VideoRepository();

    return FutureBuilder<VideoGet?>(
      future: videoRepository.getVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar vídeos'));
        }

        final videoGet = snapshot.data;
        final videos = videoGet?.videos;
        
        if (videos == null || videos.isEmpty) {
          return const Center(child: Text('Nenhum vídeo encontrado'));
        }

        return SizedBox(
          width: double.infinity,
          height: 186.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return SizedBox(
                width: 324.w,
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    
                    decoration: BoxDecoration(
                      gradient: _randomGradient(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          video.title ?? 'Sem título',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          video.description ?? 'Sem descrição',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 50,
                            ),
                            onPressed: () {
                              if (video.sId != null) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.showVideo,
                                  arguments: video.sId,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}