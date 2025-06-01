class ApiConfig {
  static const String baseUrl = 'http://52.229.206.42:4001';

  // Endpoint untuk auth
  static String get loginUrl => '$baseUrl/api-auth/post/login';
  static String get getMeUrl => '$baseUrl/api-auth/get/me';
  static String get registerUrl => '$baseUrl/api-auth/post/user';

  // Endpoint untuk user
  static String get getAllUsersUrl => '$baseUrl/api-user/get/allUser';

  // Endpoint untuk sertifikat
  static String get getAllTemplatesUrl =>
      '$baseUrl/api-sertifikat/get/allTemplate';
  static String get addTemplateUrl => '$baseUrl/api-sertifikat/post/template';
  static String get deleteTemplateUrl =>
      '$baseUrl/api-sertifikat/delete/template';
}
