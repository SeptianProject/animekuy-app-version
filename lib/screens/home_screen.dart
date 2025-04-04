import 'package:animekuy/utils/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/anime_card.dart';
import '../services/anime_service.dart';
import '../models/anime.dart';
import '../screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AnimeService _animeService = AnimeService();
  List<Anime> _trendingAnime = [];
  List<Anime> _categoryAnime = [];
  bool _isLoading = true;
  bool _isCategoryLoading = false;

  // Kategori anime
  final List<String> _categories = [
    'Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Romance',
    'Sci-Fi',
  ];
  String _selectedCategory = 'Action';

  @override
  void initState() {
    super.initState();
    _fetchTrendingAnime();
    _fetchAnimeByCategory(_selectedCategory);
  }

  Future<void> _fetchTrendingAnime() async {
    try {
      final animeList = await _animeService.getTrendingAnime();
      setState(() {
        _trendingAnime = animeList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
    }
  }

  Future<void> _fetchAnimeByCategory(String category) async {
    setState(() {
      _isCategoryLoading = true;
    });

    try {
      final animeList = await _animeService.getAnimeByCategory(category);
      setState(() {
        _categoryAnime = animeList;
        _selectedCategory = category;
        _isCategoryLoading = false;
      });
    } catch (e) {
      setState(() {
        _isCategoryLoading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimeKuy')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(ColorsConstants.primaryColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'AnimeKuy',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Favorite Anime Streaming App',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              selected: true,
              onTap: () {
                Navigator.pop(context); // tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {
                Navigator.pop(context); // tutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: const Text('Explore'),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke explore screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke favorites screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke settings screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke about screen
              },
            ),
          ],
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  // Section Trending Anime
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Trending Anime',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _trendingAnime.length,
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        return AnimeCard(anime: _trendingAnime[index]);
                      },
                    ),
                  ),

                  // Section Kategori
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),

                  // Tombol kategori
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = category == _selectedCategory;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                            onPressed: () => _fetchAnimeByCategory(category),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isSelected
                                      ? Color(ColorsConstants.primaryColor)
                                      : null,
                              foregroundColor:
                                  isSelected
                                      ? Colors.white
                                      : Color(ColorsConstants.primaryColor),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Color(ColorsConstants.primaryColor),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text(category),
                          ),
                        );
                      },
                    ),
                  ),

                  // Section anime berdasarkan kategori
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$_selectedCategory Anime',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  // Tampilkan anime berdasarkan kategori
                  _isCategoryLoading
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                      : _categoryAnime.isEmpty
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text('No anime found for this category'),
                        ),
                      )
                      : GridView.builder(
                        shrinkWrap:
                            true, // Penting agar berfungsi di dalam ListView
                        physics:
                            const NeverScrollableScrollPhysics(), // Disable scroll GridView
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: _categoryAnime.length,
                        padding: const EdgeInsets.all(8.0),
                        itemBuilder: (context, index) {
                          return AnimeCard(anime: _categoryAnime[index]);
                        },
                      ),
                ],
              ),
    );
  }
}
