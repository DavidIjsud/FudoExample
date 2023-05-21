import 'package:fudo_test/modules/home/data/dtos/post.dto.dart';
import 'package:fudo_test/modules/home/data/dtos/user.dto.dart';

abstract class LocalDataUsersPosts {
  Future<List<PostDto>> getPosts();
  Future<List<UserDto>> getUsers();
  Future<void> savePostsLocal(String rawPosts);
  Future<void> saveUsersLocal(String rawUsers);
}
