import 'package:fudo_test/modules/home/domain/entities/post.entity.dart';

abstract class GetPostsUseCase {
  Future<List<PostEntity>> getPostUseCase();
}
