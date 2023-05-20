import 'package:fudo_test/modules/home/data/repository/post_users.repository.dart';
import 'package:fudo_test/modules/home/domain/entities/user.entity.dart';
import 'package:fudo_test/modules/home/domain/usescases/getusers/get_users.usecase.dart';

class GetUsersUseCaseImpl implements GetUsersUseCase {
  final PostsUsersRepository postsUsersRepository;

  const GetUsersUseCaseImpl({
    required this.postsUsersRepository,
  });

  @override
  Future<List<UserEntity>> getUsers() async {
    return await postsUsersRepository.getUsersEntities();
  }
}
