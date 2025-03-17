import 'package:course_app/app_routes.dart';
import 'package:course_app/course/course_model.dart';
import 'package:course_app/course/course_repository.dart';
import 'package:course_app/home/home_body.dart';
import 'package:course_app/home/home_header.dart';
import 'package:course_app/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final CourseRepository _courseRepository = CourseRepository();
  List<CourseModel> _allCourses = [];
  List<CourseModel> _filteredCourses = [];
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      final courses = await _courseRepository.getCourses();
      setState(() {
        _allCourses = courses;
      });
    } catch (e) {
      print('Erro ao carregar cursos: $e');
    }
  }

  void _handleSearch(String query) {
    final searchText = query.toLowerCase();
    setState(() {
      _filteredCourses = _allCourses.where((course) {
        final title = course.title?.toLowerCase() ?? '';
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
                      courses: _showSearchResults ? _filteredCourses : _allCourses,
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
                  results: _filteredCourses,
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
  final List<CourseModel> results;
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
            final course = results[index];
            return ListTile(
              leading: const Icon(Icons.school),
              title: Text(course.title ?? 'Sem título'),
              subtitle: Text(course.description ?? 'Sem descrição'),
              onTap: () {
                onClose();
                if (course.id != null) {
                  Navigator.pushNamed(
                    context,
                    AppRoute.showVideo,
                    arguments: course.id,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Curso não encontrado')),
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
