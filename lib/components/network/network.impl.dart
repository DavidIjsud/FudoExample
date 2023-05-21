import 'dart:io';

import 'package:fudo_test/components/network/network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkUtils implements NetworkUtilsAbstract {
  final Connectivity connectivity;

  NetworkUtils({
    required this.connectivity,
  });

  static final String host = dotenv.get("HOST");
  @override
  Future<bool> hasInternetConnection() async {
    ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      try {
        final response = await http.get(Uri.parse("https://www.google.com"));
        return response.statusCode == HttpStatus.ok;
      } catch (e) {
        return false;
      }
    }
  }
}
