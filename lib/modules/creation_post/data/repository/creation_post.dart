abstract class PostCreation {
  Future<bool> addNewPost({
    required String title,
    required String body,
    required String userId,
  });
}
