import 'dart:io';
class AccessGuard {
  static bool isLikelyIran() {
    final tz = DateTime.now().timeZoneName.toLowerCase();
    final locales = Platform.localeName.toLowerCase();
    return tz.contains('iran') || locales.contains('fa_ir') || locales.contains('fa-ir') || locales.endsWith('_ir');
  }
}
