import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../services/anime_service.dart';
import '../widgets/anime_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final AnimeService _animeService = AnimeService();
  List<Anime> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchAnime(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _animeService.searchAnime(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search anime...',
            border: InputBorder.none,
          ),
          onSubmitted: _searchAnime,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _searchAnime(_searchController.text),
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _searchResults.isEmpty
              ? const Center(child: Text('No results found'))
              : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return AnimeCard(anime: _searchResults[index]);
                },
              ),
    );
  }
}
