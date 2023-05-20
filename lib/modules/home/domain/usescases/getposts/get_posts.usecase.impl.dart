import 'package:fudo_test/modules/home/data/repository/post_users.repository.dart';
import 'package:fudo_test/modules/home/domain/entities/post.entity.dart';
import 'package:fudo_test/modules/home/domain/usescases/getposts/get_posts.usecase.dart';

class GetPostsUseCaseImpl implements GetPostsUseCase {
  final PostsUsersRepository postsUsersRepository;

  const GetPostsUseCaseImpl({
    required this.postsUsersRepository,
  });

  @override
  Future<List<PostEntity>> getPostUseCase() async {
    return await postsUsersRepository.getPostsEntities();
  }
}
