import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "http://mohamdmadas.byethost11.com/products.php";
  Future<List<dynamic>> fetchExercises() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch exercises. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error: $e");
      throw Exception('Error fetching exercises: $e');
    }
  }
}
