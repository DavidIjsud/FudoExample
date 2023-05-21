import 'package:fudo_test/components/network/network.dart';
import 'package:fudo_test/components/reporter_error_network/reporter_error_connection.dart';
import 'package:fudo_test/exceptions/slow_internet_exception.dart';
import 'package:fudo_test/modules/creation_post/data/repository/creation_post.dart';
import 'package:fudo_test/modules/creation_post/data/service/add_post.service.dart';

class PostCreationImpl implements PostCreation {
  final PostService postService;
  final NetworkUtilsAbstract networkUtilsAbstract;

  const PostCreationImpl({
    required this.postService,
    required this.networkUtilsAbstract,
  });

  @override
  Future<bool> addNewPost({
    required String title,
    required String body,
    required String userId,
  }) async {
    bool hasUserConnectionToInternet =
        await networkUtilsAbstract.hasInternetConnection();
    bool postAdded = false;
    if (hasUserConnectionToInternet) {
      try {
        postAdded = await postService.addNewPost(
            title: title, body: body, userId: userId);
      } on SlowInternetException {
        ReporterErrorConnection.instance
            .addNewValue("Tu conexion a internet esta lento");
      }
    } else {
      ReporterErrorConnection.instance.addNewValue("Conectate a internet.");
    }

    return postAdded;
  }
}
