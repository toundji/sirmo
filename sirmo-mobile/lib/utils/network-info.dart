class NetworkInfo {
  static String baseUrl = "http://192.168.1.131:3000/api/";
  // static String baseUrl = "https://sirmo-api.herokuapp.com/api/";

  static String? token;

  static String get auth => "Bearer ${NetworkInfo.token}";
  static Map<String, String> headers = {
    "Authorization": "Bearer ${NetworkInfo.token}"
  };

  static String get imageProfile => "${NetworkInfo.baseUrl}users/profile/image";
}
