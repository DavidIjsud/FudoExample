part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

abstract class PostsStates implements HomeState {}

abstract class UsersStates implements HomeState {}
