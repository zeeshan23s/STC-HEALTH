import '../exports.dart';
import 'package:http/http.dart' as http;

class ProductController {
  static Future<List<Product>> getProducts() async {
    Uri url = Uri.parse('https://fakestoreapi.com/products');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Product> products = [];
      List<dynamic> data = jsonDecode(response.body);
      for (var item in data) {
        products.add(Product.fromJson(jsonEncode(item)));
      }
      return products;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }
}
