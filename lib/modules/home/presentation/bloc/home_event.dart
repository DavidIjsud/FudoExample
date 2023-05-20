part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

abstract class UsersEvents implements HomeEvent {}

abstract class PostsEvents implements HomeEvent {}
