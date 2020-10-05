import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ikechukwu_israel/utils/custom_exception.dart';

class ApiService {
  static final ApiService _singleton = ApiService();
  static ApiService get instance => _singleton;
  final String _baseUrl = 'https://ven10.co/';

  Future<dynamic> fetchData(String endpoint) async {
    try {
      final response = await http.get(_baseUrl + endpoint);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw BadStatusResponseException('Failed to fetch data.');
      }
    } catch(e) {
      throw NetworkErrorException(
          'An error occurred. Please check your internet connection.');
    }
  }
}
