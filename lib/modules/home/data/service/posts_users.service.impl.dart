import 'dart:convert';
import 'dart:developer';

import 'package:fudo_test/components/network/network.impl.dart';
import 'package:fudo_test/exceptions/slow_internet_exception.dart';
import 'package:fudo_test/modules/home/data/dtos/user.dto.dart';
import 'package:fudo_test/modules/home/data/dtos/post.dto.dart';
import 'package:fudo_test/modules/home/data/service/posts_users.service.dart';
import 'package:http/http.dart' as http;

class PostUserServiceImpl implements PostUserService {
  @override
  Future<List<PostDto>> getPosts() async {
    String url = "${NetworkUtils.host}posts";
    Uri uri = Uri.parse(url);

    http.Response result;

    result = await http
        .get(
      uri,
    )
        .timeout(const Duration(seconds: 1), onTimeout: () async {
      log("Slow internet");
      throw SlowInternetException();
    });

    return List.from(json.decode(result.body))
        .map((user) => PostDto.fromJson(user))
        .toList();
  }

  @override
  Future<List<UserDto>> getUsers() async {
    String url = "${NetworkUtils.host}users";
    Uri uri = Uri.parse(url);
    http.Response result;

    result = await http
        .get(
      uri,
    )
        .timeout(const Duration(seconds: 1), onTimeout: () async {
      log("Slow internet");
      throw SlowInternetException();
    });

    return List.from(json.decode(result.body))
        .map((user) => UserDto.fromJson(user))
        .toList();
  }
}
