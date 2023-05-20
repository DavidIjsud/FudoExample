import 'dart:io';

import 'package:fudo_test/components/network/network.dart';
import 'package:fudo_test/exceptions/not_internet_exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkUtils implements NetworkUtilsAbstract {
  NetworkUtils();

  static final String host = dotenv.get("HOST");
  @override
  Future<bool> hasInternetConnection() async {
    try {
      final result =
          await InternetAddress.lookup('developers.mercadolibre.com.bo');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      throw NoInternetException();
    }
    throw NoInternetException();
  }
}
