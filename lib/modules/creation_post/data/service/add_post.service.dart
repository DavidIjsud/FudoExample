abstract class PostService {
  Future<bool> addNewPost({
    required String title,
    required String body,
    required String userId,
  });
}
