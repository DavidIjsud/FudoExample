import 'package:bloc/bloc.dart';
import 'package:fudo_test/modules/creation_post/domain/usecases/add_new_post.usecase.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final NewPostUseCase newPostUseCase;

  PostBloc({
    required this.newPostUseCase,
  }) : super(PostInitial()) {
    on<OnAddNewPost>(_onAddNewPost);
  }

  Future<void> _onAddNewPost(
      OnAddNewPost event, Emitter<PostState> emit) async {
    emit(LoadingPost());
    try {
      bool postAdded = await newPostUseCase.addNewPost(
          title: event.title, body: event.body, userId: event.userId);
      if (postAdded) {
        emit(PostPostedSuccessfull());
      } else {
        emit(PostInitial());
      }
    } catch (_) {
      emit(UnknowErrorOnPost());
    }
  }
}
