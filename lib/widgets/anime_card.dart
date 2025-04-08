import 'package:animekuy/utils/constants.dart';
import 'package:flutter/material.dart';
import '../models/anime.dart';
import '../screens/anime_detail_screen.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;

  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailScreen(anime: anime),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 140,
        // Tetapkan tinggi untuk membatasi ukuran total card
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                anime.imageUrl,
                height: 180,
                width: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: 140,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            // Bagian judul menggunakan Expanded untuk menyesuaikan ruang yang tersisa
            Expanded(
              child: Text(
                anime.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(ColorsConstants.textColor), 
                ),
              ),
            ),
            // Bagian rating selalu di bawah
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  anime.rating.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(ColorsConstants.textColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
