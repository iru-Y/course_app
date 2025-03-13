import 'package:course_app/video/video_model.dart';
import 'package:course_app/video/video_repo.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  Video? _video;
  late String _videoId;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _videoId = ModalRoute.of(context)!.settings.arguments as String;
    _fetchVideo();
  }

  Future<void> _fetchVideo() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      final Video? video = await VideoRepository().getVideoById(_videoId);

      if (!mounted) return;

      if (video == null) {
        throw Exception('Vídeo não encontrado');
      }

      if (video.url == null || video.url!.isEmpty) {
        throw Exception('URL do vídeo não disponível');
      }
     
      if (!video.url!.startsWith('http')) {
        throw Exception('Formato de URL inválido');
      }

      await _initializeController(video.url!);

      if (mounted) {
        setState(() {
          _video = video;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Erro ao carregar vídeo: $e");
      _handleError(e.toString());
    }
  }

  Future<void> _initializeController(String url) async {
    _controller = VideoPlayerController.network(url)
      ..addListener(_videoListener)
      ..setLooping(true);

    await _controller.initialize();
  }

  void _videoListener() {
    if (mounted) setState(() {});
  }

  void _handleError(String message) {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = message.replaceAll('Exception: ', '');
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingScreen();
    }

    if (_hasError) {
      return _buildErrorScreen();
    }

    return _buildVideoPlayer();
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      appBar: AppBar(title: const Text("Carregando...")),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Carregando vídeo...'),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Erro"),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchVideo),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 50, color: Colors.red),
              const SizedBox(height: 20),
              Text(
                _errorMessage.isNotEmpty
                    ? _errorMessage
                    : 'Falha ao carregar o vídeo',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
                onPressed: _fetchVideo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_video?.title ?? 'Vídeo'),
        actions: [
          IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: _togglePlayPause,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          _buildVideoControls(),
        ],
      ),
    );
  }

  Widget _buildVideoControls() {
    return Container(
      color: Colors.black12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_10),
            onPressed: () => _seekRelative(-10),
          ),
          IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 40,
            ),
            onPressed: _togglePlayPause,
          ),
          IconButton(
            icon: const Icon(Icons.forward_10),
            onPressed: () => _seekRelative(10),
          ),
        ],
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _seekRelative(int seconds) {
    final newPosition = _controller.value.position + Duration(seconds: seconds);
    final clampedSeconds = newPosition.inSeconds.clamp(
      0,
      _controller.value.duration.inSeconds,
    );
    _controller.seekTo(Duration(seconds: clampedSeconds));
  }
}