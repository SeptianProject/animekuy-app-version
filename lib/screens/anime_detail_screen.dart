import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../widgets/video_player.dart';

class AnimeDetailScreen extends StatefulWidget {
  final Anime anime;

  const AnimeDetailScreen({super.key, required this.anime});

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.anime.title,
          style: const TextStyle(color: Colors.white),
        ), // Set text color to white
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ), // Set icon color to white
            onPressed: () {
              // Toggle favorite
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner image
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(widget.anime.imageUrl, fit: BoxFit.cover),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.anime.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ), // Set text color to white
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rating: ${widget.anime.rating}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ), // Set text color to white
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.anime.synopsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ), // Set text color to white
                  ),
                  const SizedBox(height: 24),

                  // Video Player placeholder
                  const Text(
                    'Episodes:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ), // Set text color to white
                  ),
                  const SizedBox(height: 8),
                  const AnimeVideoPlayer(videoUrl: 'placeholder_url'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
