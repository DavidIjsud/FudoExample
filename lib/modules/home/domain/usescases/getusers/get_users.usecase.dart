import 'package:fudo_test/modules/home/domain/entities/user.entity.dart';

abstract class GetUsersUseCase {
  Future<List<UserEntity>> getUsers();
}
