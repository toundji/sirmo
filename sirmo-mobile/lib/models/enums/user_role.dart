/* eslint-disable prettier/prettier */
import '../user.dart';

class UserRole {
  static String get CONDUCTEUR => 'CONDUCTEUR';
  static String get POLICE => 'POLICE';
  static String get USER => 'USER';
  static String get ADMIN => 'ADMIN';

  static bool isAdmin(User user) {
    return user.roles != null && user.roles!.contains('ADMIN');
  }

  static bool isPolice(User user) {
    return user.roles != null && user.roles!.contains('POLICE');
  }

  static bool isConducteur(User user) {
    return user.roles != null && user.roles!.contains('CONDUCTEUR');
  }
}
