import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fudo_test/components/network/network.impl.dart';
import 'package:fudo_test/environments/enviroment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fudo_test/modules/creation_post/data/repository/creation_post.impl.dart';
import 'package:fudo_test/modules/creation_post/data/service/add_post.impl.service.dart';
import 'package:fudo_test/modules/creation_post/domain/usecases/add_new_post.usecase.impl.dart';
import 'package:fudo_test/modules/creation_post/presentation/bloc/post_bloc.dart';
import 'package:fudo_test/modules/home/data/local_data/local_data.impl.dart';
import 'package:fudo_test/modules/home/data/repository/posts_users.repository.impl.dart';
import 'package:fudo_test/modules/home/data/service/posts_users.service.impl.dart';
import 'package:fudo_test/modules/home/domain/usescases/getposts/get_posts.usecase.impl.dart';
import 'package:fudo_test/modules/home/domain/usescases/getusers/get_users.impl.usecase.dart';
import 'package:fudo_test/modules/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_test/modules/login/presentation/login.page.dart';

void initApp(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initEnv(environment);
  runApp(const MyApp());
}

Future<void> _initEnv(AppEnvironment environment) async {
  switch (environment) {
    case AppEnvironment.dev:
      await dotenv.load(fileName: 'dev.env');
      break;
    case AppEnvironment.stag:
      await dotenv.load(fileName: 'stag.env');
      break;
    case AppEnvironment.prod:
      await dotenv.load(fileName: 'prod.env');
      break;
    default:
      await dotenv.load(fileName: 'prod.env');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NetworkUtils networkUtils = NetworkUtils(
      connectivity: Connectivity(),
    );

    final PostsUsersRepositoryImpl postUserServiceRepository =
        PostsUsersRepositoryImpl(
      postUserService: PostUserServiceImpl(),
      networkUtilsAbstract: networkUtils,
      localDataUsersPosts: LocalDataUsersPostsImpl(),
    );

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostBloc(
              newPostUseCase: NewPostUseCaseImpl(
                postCreation: PostCreationImpl(
                    postService: PostServiceImpl(),
                    networkUtilsAbstract: networkUtils),
              ),
            ),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              getPostsUseCase: GetPostsUseCaseImpl(
                  postsUsersRepository: postUserServiceRepository),
              getUsersUseCase: GetUsersUseCaseImpl(
                postsUsersRepository: postUserServiceRepository,
              ),
            ),
            child: Container(),
          )
        ],
        child: const MaterialApp(
          title: 'Presto Latam',
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ));
  }
}
