import 'package:course_app/app_routes.dart';
import 'package:course_app/home/home_body.dart';
import 'package:course_app/home/home_header.dart';
import 'package:course_app/video/video_model.dart';
import 'package:course_app/video/video_repo.dart';
import 'package:course_app/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final VideoRepository _videoRepository = VideoRepository();
  List<Video> _allVideos = [];
  List<Video> _filteredVideos = [];
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      final videoGet = await _videoRepository.getVideos();
      if (videoGet != null && videoGet.videos != null) {
        setState(() {
          _allVideos = videoGet.videos!;
        });
      }
    } catch (e) {
      print('Erro ao carregar vídeos: $e');
    }
  }

  void _handleSearch(String query) {
    final searchText = query.toLowerCase();
    setState(() {
      _filteredVideos =
          _allVideos.where((video) {
            final title = video.title?.toLowerCase() ?? '';
            return title.contains(searchText);
          }).toList();
      _showSearchResults = query.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerMenu(),
        body: Stack(
          children: [
            Column(
              children: [
                HomeHeader(
                  searchController: _searchController,
                  onSearchChanged: _handleSearch,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: HomeBody(
                      videos: _showSearchResults ? _filteredVideos : _allVideos,
                    ),
                  ),
                ),
              ],
            ),
            if (_showSearchResults)
              Positioned(
                top: 160,
                left: 20,
                right: 20,
                child: SearchResultsOverlay(
                  results: _filteredVideos,
                  onClose: () => setState(() => _showSearchResults = false),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SearchResultsOverlay extends StatelessWidget {
  final List<Video> results;
  final VoidCallback onClose;

  const SearchResultsOverlay({
    super.key,
    required this.results,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            final video = results[index];
            return ListTile(
              leading: const Icon(Icons.video_library),
              title: Text(video.title ?? 'Sem título'),
              subtitle: Text(video.description ?? 'Sem descrição'),
              onTap: () {
                onClose();
                if (video.sId != null) {
                  Navigator.pushNamed(
                    context,
                    AppRoute.showVideo,
                    arguments: video.sId,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vídeo não encontrado')),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
