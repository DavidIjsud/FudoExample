import 'package:fudo_test/modules/home/domain/entities/post.entity.dart';
import 'package:fudo_test/modules/home/domain/entities/user.entity.dart';

abstract class PostsUsersRepository {
  Future<List<PostEntity>> getPostsEntities();
  Future<List<UserEntity>> getUsersEntities();
}
