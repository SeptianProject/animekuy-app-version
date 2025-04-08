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
      backgroundColor: const Color(
        ColorsConstants.backgroundColor,
      ), // Set background color to dark
      appBar: AppBar(
        title: const Text(
          'AnimeKuy',
          style: TextStyle(color: Color(ColorsConstants.textColor)),
        ), // Set text color to white
        backgroundColor: const Color(
          ColorsConstants.surfaceColor,
        ), // Set AppBar background to secondary dark
      ),
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
              leading: const Icon(
                Icons.home,
                color: Color(ColorsConstants.textColor),
              ),
              title: const Text(
                'Home',
                style: TextStyle(color: Color(ColorsConstants.textColor)),
              ),
              selected: true,
              onTap: () {
                Navigator.pop(context); // tutup drawer
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search,
                color: Color(ColorsConstants.textColor),
              ),
              title: const Text(
                'Search',
                style: TextStyle(color: Color(ColorsConstants.textColor)),
              ),
              onTap: () {
                Navigator.pop(context); // tutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.explore,
                color: Color(ColorsConstants.textColor),
              ),
              title: const Text(
                'Explore',
                style: TextStyle(color: Color(ColorsConstants.textColor)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke explore screen
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Color(ColorsConstants.textColor),
              ),
              title: const Text(
                'Favorites',
                style: TextStyle(color: Color(ColorsConstants.textColor)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke favorites screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color(ColorsConstants.textColor),
              ),
              title: const Text(
                'Settings',
                style: TextStyle(color: Color(ColorsConstants.textColor)),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate ke settings screen
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Color(ColorsConstants.textColor),
              ),
              title: const Text(
                'About',
                style: TextStyle(color: Color(ColorsConstants.textColor)),
              ),
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
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: const Color(ColorsConstants.textColor),
                      ),
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
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: const Color(ColorsConstants.textColor),
                      ),
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(ColorsConstants.textColor),
                      ),
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
                          child: Text(
                            'No anime found for this category',
                            style: TextStyle(
                              color: Color(ColorsConstants.textColor),
                            ),
                          ),
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
