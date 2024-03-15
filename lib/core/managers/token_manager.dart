import 'package:get_storage/get_storage.dart';

class TokenManager {
  final box = GetStorage();

  Future trimAndSaveToken(String token) async {
    List<String> parts = token.split('|');
    String trimmedToken = parts.length > 1 ? parts[1] : '';
    await box.write('token', trimmedToken);
  }

  Future<String?> getToken() async {
    final token = await box.read('token');
    return token;
  }

  Future<void> removeToken() async {
    await box.remove('token');
  }

  Future<void> saveToken(String token) async {
    await box.write('token', token);
  }

  Future<String?> updateToken(String token) async {
    await removeToken();
    await saveToken(token);
    return token;
  }
}
