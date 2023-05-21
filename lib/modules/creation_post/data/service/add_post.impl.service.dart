import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fudo_test/components/network/network.impl.dart';
import 'package:fudo_test/exceptions/slow_internet_exception.dart';
import 'package:fudo_test/modules/creation_post/data/service/add_post.service.dart';
import 'package:http/http.dart' as http;

class PostServiceImpl implements PostService {
  @override
  Future<bool> addNewPost(
      {required String title,
      required String body,
      required String userId}) async {
    String url = "${NetworkUtils.host}posts";
    Uri uri = Uri.parse(url);

    http.Response result;

    result = await http.post(uri,
        body: jsonEncode({
          title: title,
          body: body,
          userId: userId,
        }),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        }).timeout(const Duration(seconds: 1), onTimeout: () async {
      log("Slow internet");
      throw SlowInternetException();
    });

    return result.statusCode == HttpStatus.created;
  }
}
