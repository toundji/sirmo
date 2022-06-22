class NetworkInfo {
  static String baseUrl = "https://sirmo-api.herokuapp.com/api/";
  static String? token;

  static String get auth => "Bearer ${NetworkInfo.token}";
  static Map<String, String> headers = {
    "Authorization": "Bearer ${NetworkInfo.token}"
  };

  static String get imageProfile => "${NetworkInfo.baseUrl}users/profile/image";
}
