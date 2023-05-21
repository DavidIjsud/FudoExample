import 'package:fudo_test/modules/home/domain/entities/user.entity.dart';
import 'package:fudo_test/modules/home/presentation/bloc/home_bloc.dart';

class UsersGotSuccessfull implements UsersStates {
  final List<UserEntity> users;

  const UsersGotSuccessfull({
    required this.users,
  });
}

class LoadingUsers implements UsersStates {}

class UnknowErrorUsers implements UsersStates {}
