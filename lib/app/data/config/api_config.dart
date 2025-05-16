import 'package:get/get.dart';

class ApiConfig {
  // Buat variabel reaktif untuk menyimpan base URL
  static final RxString _baseUrl = 'http://192.168.18.4:4000'.obs;

  // Getter untuk mendapatkan base URL saat ini
  static String get baseUrl => _baseUrl.value;

  // Setter untuk mengubah base URL
  static void setBaseUrl(String url) {
    _baseUrl.value = url;
  }

  // Endpoint untuk auth
  static String get loginUrl => '$baseUrl/api-auth/post/login';
  static String get getMeUrl => '$baseUrl/api-auth/get/me';
  static String get registerUrl => '$baseUrl/api-auth/post/user';

  // Endpoint untuk user
  static String get getAllUsersUrl => '$baseUrl/api-user/get/allUser';

  // Tambahkan endpoint lain sesuai kebutuhan
}
