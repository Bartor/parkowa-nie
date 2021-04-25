import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:parkowa_nie/configuration.dart';
import 'package:slugify/slugify.dart';
import 'package:http/http.dart' as http;

class CitiesService {
  Map<String, String> _addresses;

  CitiesService() {
    _init();
  }

  void _setAddresses(String json) {
    final jsonData = jsonDecode(json);
    _addresses = {};
    jsonData['cities']
        .forEach((city, address) => _addresses[slugify(city)] = address);
  }

  Future<void> _init() async {
    if (_addresses == null) {
      _setAddresses(await rootBundle.loadString('assets/cities.json'));
      _fetchUpdate();
    }
  }

  Future<void> _fetchUpdate() async {
    try {
      final response = await http.get(Uri.parse(CITIES_JSON_URL));

      if (response.statusCode == 200) {
        _setAddresses(response.body);
      }
    } catch (e) {}
  }

  Future<String> resolveEmail(String city) async {
    await _init();
    return _addresses[slugify(city)];
  }
}
