```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      //Handle different HTTP error codes more specifically
      if(response.statusCode == 404){
        throw Exception('Resource not found: ${response.statusCode}');
      } else if (response.statusCode == 500) {
        throw Exception('Server error: ${response.statusCode}');
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    }
  } on http.ClientException catch (e) {
    //Handle network errors specifically
    print('Network error: $e');
    return null; //Or throw a custom exception
  } on FormatException catch (e) {
    //Handle JSON decoding errors
    print('JSON decoding error: $e');
    return null; //Or throw a custom exception
  } catch (e) {
    print('Unexpected error: $e');
    rethrow; //Rethrow for higher-level handling
  }
}
```