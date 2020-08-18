import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://www.googleapis.com/books/v1/volumes?q=';

class Networking {
  final String keyword;
  const Networking({@required this.keyword});
  Future<dynamic> getBooksData() async {
    http.Response response = await http.get(baseUrl + keyword);
    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      return decodeJson;
    } else
      return null;
  }
}


