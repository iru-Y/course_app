import 'package:course_app/video/video_model.dart';
import 'package:course_app/widgets/card_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  final List<Video> videos;

  const HomeBody({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SectionHeader(title: 'Seus cursos', buttonText: 'Ver todos'),
        _buildVideoList(),
        const _SectionHeader(title: 'Cursos salvos', buttonText: 'Ver todos'),
        _buildVideoList(),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildVideoList() {
    return SizedBox(
      height: 186.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return SizedBox(
            width: 324.w,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: _randomGradient(),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title ?? 'Sem título',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        video.description ?? 'Sem descrição',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.play_circle_fill, 
                          color: Colors.white, size: 40),
                        onPressed: () {
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
  }

  LinearGradient _randomGradient() {
    return LinearGradient(colors: [Colors.blue, Colors.indigo]);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;

  const _SectionHeader({
    required this.title,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}