class Anime {
  final int id;
  final String title;
  final String imageUrl;
  final String synopsis;
  final double rating;
  final int episodes;
  final List<String> genres;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.rating,
    required this.episodes,
    required this.genres,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      synopsis: json['synopsis'] ?? 'No synopsis available',
      rating: (json['score'] ?? 0.0).toDouble(),
      episodes: json['episodes'] ?? 0,
      genres:
          (json['genres'] as List?)
              ?.map((genre) => genre['name'] as String)
              .toList() ??
          [],
    );
  }
}
