import '../exports.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? _message;

  bool _isLoading = false;

  String? get token => _token;

  String? get message => _message;

  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    _isLoading = true;

    notifyListeners();

    try {
      Map<String, dynamic> response =
          await AuthController.login(username, password);
      _token = response['token'];
      _message = 'Login Successfully!';
    } catch (e) {
      _message = 'Login Unsuccessful!';
    }

    _isLoading = false;

    notifyListeners();
  }
}
