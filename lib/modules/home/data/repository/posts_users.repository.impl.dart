import 'dart:convert';

import 'package:fudo_test/components/network/network.dart';
import 'package:fudo_test/components/reporter_error_network/reporter_error_connection.dart';
import 'package:fudo_test/exceptions/slow_internet_exception.dart';
import 'package:fudo_test/modules/home/data/dtos/post.dto.dart';
import 'package:fudo_test/modules/home/data/dtos/user.dto.dart';
import 'package:fudo_test/modules/home/data/local_data/local_data.dart';
import 'package:fudo_test/modules/home/data/repository/post_users.repository.dart';
import 'package:fudo_test/modules/home/data/service/posts_users.service.dart';
import 'package:fudo_test/modules/home/domain/entities/user.entity.dart';
import 'package:fudo_test/modules/home/domain/entities/post.entity.dart';

class PostsUsersRepositoryImpl implements PostsUsersRepository {
  final PostUserService postUserService;
  final NetworkUtilsAbstract networkUtilsAbstract;
  final LocalDataUsersPosts localDataUsersPosts;

  const PostsUsersRepositoryImpl({
    required this.postUserService,
    required this.networkUtilsAbstract,
    required this.localDataUsersPosts,
  });

  @override
  Future<List<PostEntity>> getPostsEntities() async {
    bool hasUserConnectionToInternet =
        await networkUtilsAbstract.hasInternetConnection();
    List<PostDto> postsDtos = [];
    if (hasUserConnectionToInternet) {
      try {
        postsDtos = await postUserService.getPosts();
        await localDataUsersPosts.savePostsLocal(json.encode(postsDtos));
      } on SlowInternetException {
        postsDtos = await localDataUsersPosts.getPosts();
        ReporterErrorConnection.instance
            .addNewValue("Tu conexion a internet esta lento");
      }
    } else {
      postsDtos = await localDataUsersPosts.getPosts();
      ReporterErrorConnection.instance.addNewValue("Conectate a internet.");
    }
    return postsDtos
        .map((postDto) => PostEntity(title: postDto.title, body: postDto.body))
        .toList();
  }

  @override
  Future<List<UserEntity>> getUsersEntities() async {
    bool hasUserConnectionToInternet =
        await networkUtilsAbstract.hasInternetConnection();
    List<UserDto> usersDtos = [];
    if (hasUserConnectionToInternet) {
      try {
        usersDtos = await postUserService.getUsers();
        await localDataUsersPosts.saveUsersLocal(json.encode(usersDtos));
      } on SlowInternetException {
        usersDtos = await localDataUsersPosts.getUsers();
        ReporterErrorConnection.instance
            .addNewValue("Tu conexion a internet esta lento");
      }
    } else {
      usersDtos = await localDataUsersPosts.getUsers();
      ReporterErrorConnection.instance.addNewValue("Conectate a internet.");
    }
    return usersDtos
        .map((userDto) =>
            UserEntity(name: userDto.name, username: userDto.username))
        .toList();
  }
}
