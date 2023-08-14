import 'package:http/http.dart' as http;
import '../exports.dart';

class AuthController {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    Uri url = Uri.parse('https://fakestoreapi.com/auth/login');

    final response = await http
        .post(url, body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login Unsuccessful!');
    }
  }
}
