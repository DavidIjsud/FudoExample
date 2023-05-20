import 'package:fudo_test/components/network/network.dart';
import 'package:fudo_test/modules/home/data/dtos/post.dto.dart';
import 'package:fudo_test/modules/home/data/dtos/user.dto.dart';
import 'package:fudo_test/modules/home/data/repository/post_users.repository.dart';
import 'package:fudo_test/modules/home/data/service/posts_users.service.dart';
import 'package:fudo_test/modules/home/domain/entities/user.entity.dart';
import 'package:fudo_test/modules/home/domain/entities/post.entity.dart';

class PostsUsersRepositoryImpl implements PostsUsersRepository {
  final PostUserService postUserService;
  final NetworkUtilsAbstract networkUtilsAbstract;

  const PostsUsersRepositoryImpl({
    required this.postUserService,
    required this.networkUtilsAbstract,
  });

  @override
  Future<List<PostEntity>> getPostsEntities() async {
    await networkUtilsAbstract.hasInternetConnection();
    List<PostDto> postsDtos = await postUserService.getPosts();
    return postsDtos
        .map((postDto) => PostEntity(title: postDto.title, body: postDto.body))
        .toList();
  }

  @override
  Future<List<UserEntity>> getUsersEntities() async {
    await networkUtilsAbstract.hasInternetConnection();
    List<UserDto> usersDtos = await postUserService.getUsers();
    return usersDtos
        .map((userDto) =>
            UserEntity(name: userDto.name, username: userDto.username))
        .toList();
  }
}
