part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class LoadingPost implements PostInitial {}

class PostPostedSuccessfull implements PostInitial {}

class UnknowErrorOnPost implements PostInitial {}
