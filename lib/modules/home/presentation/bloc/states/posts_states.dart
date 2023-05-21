import 'package:fudo_test/modules/home/domain/entities/post.entity.dart';
import 'package:fudo_test/modules/home/presentation/bloc/home_bloc.dart';

class PostsGotSuccessfull implements PostsStates {
  final List<PostEntity> posts;

  const PostsGotSuccessfull({
    required this.posts,
  });
}

class LoadingPosts implements PostsStates {}

class UnknownErrorPosts implements PostsStates {}
