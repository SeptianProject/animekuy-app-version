class ApiConstants {
  static const String baseUrl = 'https://api.jikan.moe/v4';
  static const int apiRequestDelay =
      4000; // Jikan API has rate limiting (4 seconds)
}

class AppConstants {
  static const String appName = 'AnimeKuy';
  static const String appVersion = '1.0.0';
}

class ColorsConstants {
  static const int primaryColor = 0xFF7A34CB;
  static const int secondaryColor = 0xFF03DAC6;
  static const int backgroundColor = 0xFFFFFFFF;
  static const int textColor = 0xFF000000;
  static const int errorColor = 0xFFFF0000;
}
