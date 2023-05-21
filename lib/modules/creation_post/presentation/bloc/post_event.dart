part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class OnAddNewPost implements PostEvent {
  final String title, body, userId;
  const OnAddNewPost({
    required this.title,
    required this.body,
    required this.userId,
  });
}
