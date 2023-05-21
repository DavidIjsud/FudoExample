import 'dart:convert';

import 'package:fudo_test/modules/home/data/dtos/user.dto.dart';
import 'package:fudo_test/modules/home/data/dtos/post.dto.dart';
import 'package:fudo_test/modules/home/data/local_data/local_data.dart';
import 'package:fudo_test/shared/preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataUsersPostsImpl implements LocalDataUsersPosts {
  @override
  Future<List<PostDto>> getPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsCrowData = prefs.getString(posts);
    return postsCrowData != null
        ? List.from(json.decode(postsCrowData))
            .map((post) => PostDto.fromJson(post))
            .toList()
        : [];
  }

  @override
  Future<List<UserDto>> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersCrowData = prefs.getString(users);
    return usersCrowData != null
        ? List.from(json.decode(usersCrowData))
            .map((user) => UserDto.fromJson(user))
            .toList()
        : [];
  }

  @override
  Future<void> savePostsLocal(String rawPosts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(posts, rawPosts);
  }

  @override
  Future<void> saveUsersLocal(String rawUsers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(users, rawUsers);
  }
}
