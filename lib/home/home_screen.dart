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
  bool _showSearchResults = false;
  List<String> _searchResults = [];

  void _handleSearch(String query) {
    setState(() {
      _showSearchResults = query.isNotEmpty;
      // Simulação de resultados (substitua pela sua lógica real)
      _searchResults = query.isNotEmpty
          ? List.generate(5, (index) => "Resultado ${index + 1} para '$query'")
          : [];
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
                    child: HomeBody(),
                  ),
                ),
              ],
            ),
            if (_showSearchResults)
              Positioned(
                top: 160, // Ajuste conforme altura do seu header
                left: 20,
                right: 20,
                child: _SearchResultsOverlay(
                  results: _searchResults,
                  onClose: () => setState(() => _showSearchResults = false),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultsOverlay extends StatelessWidget {
  final List<String> results;
  final VoidCallback onClose;

  const _SearchResultsOverlay({
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
          itemBuilder: (context, index) => ListTile(
            title: Text(results[index]),
            onTap: onClose,
          ),
        ),
      ),
    );
  }
}