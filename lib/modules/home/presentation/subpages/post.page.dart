import 'package:flutter/material.dart';
import 'package:fudo_test/modules/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_test/modules/home/presentation/bloc/states/posts_states.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          current is SlowInternetPostsState ||
          current is NoInternetPostsState ||
          current is UnknownErrorPosts,
      listener: (_, state) {
        if (state is UnknownErrorPosts) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Tuvimos un problema al obtener los posts",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state is NoInternetPostsState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Conectate a internet",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state is SlowInternetPostsState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Parece que tu internet anda lento",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
      },
      buildWhen: (previous, current) =>
          current is LoadingPosts || current is PostsGotSuccessfull,
      builder: (context, state) {
        if (state is PostsGotSuccessfull) {
          return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (_, indexInPostList) {
                return ListTile(
                  title: Text(state.posts[indexInPostList].title),
                  subtitle: Text(state.posts[indexInPostList].body),
                );
              });
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
