import 'package:fudo_test/modules/creation_post/data/repository/creation_post.dart';
import 'package:fudo_test/modules/creation_post/domain/usecases/add_new_post.usecase.dart';

class NewPostUseCaseImpl implements NewPostUseCase {
  final PostCreation postCreation;

  const NewPostUseCaseImpl({
    required this.postCreation,
  });

  @override
  Future<bool> addNewPost(
      {required String title,
      required String body,
      required String userId}) async {
    return await postCreation.addNewPost(
        title: title, body: body, userId: userId);
  }
}
