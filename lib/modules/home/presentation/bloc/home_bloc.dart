import 'package:bloc/bloc.dart';

import 'package:fudo_test/modules/home/domain/usescases/getposts/get_posts.usecase.dart';
import 'package:fudo_test/modules/home/domain/usescases/getusers/get_users.usecase.dart';
import 'package:fudo_test/modules/home/presentation/bloc/events/posts_events.dart';
import 'package:fudo_test/modules/home/presentation/bloc/events/users_events.dart';
import 'package:fudo_test/modules/home/presentation/bloc/states/posts_states.dart';
import 'package:fudo_test/modules/home/presentation/bloc/states/users_states.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUseCase getUsersUseCase;
  final GetPostsUseCase getPostsUseCase;

  HomeBloc({
    required this.getPostsUseCase,
    required this.getUsersUseCase,
  }) : super(HomeInitial()) {
    on<OnGetPosts>(_onGetPosts);
    on<OnGetUsers>(_onGetUsers);
  }

  Future<void> _onGetPosts(OnGetPosts event, Emitter<HomeState> emit) async {
    emit(LoadingPosts());
    try {
      emit(PostsGotSuccessfull(
        posts: await getPostsUseCase.getPostUseCase(),
      ));
    } catch (e) {
      emit(UnknownErrorPosts());
    }
  }

  Future<void> _onGetUsers(OnGetUsers event, Emitter<HomeState> emit) async {
    emit(LoadingUsers());
    try {
      emit(UsersGotSuccessfull(
        users: await getUsersUseCase.getUsers(),
      ));
    } catch (e) {
      emit(UnknowErrorUsers());
    }
  }
}
