import 'package:flutter/material.dart';
import 'package:fudo_test/modules/home/presentation/bloc/events/posts_events.dart';
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
      listenWhen: (previous, current) => current is UnknownErrorPosts,
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
      },
      buildWhen: (previous, current) =>
          current is LoadingPosts || current is PostsGotSuccessfull,
      builder: (context, state) {
        if (state is PostsGotSuccessfull) {
          return RefreshIndicator(
              child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (_, indexInPostList) {
                    return ListTile(
                      title: Text(state.posts[indexInPostList].title),
                      subtitle: Text(state.posts[indexInPostList].body),
                    );
                  }),
              onRefresh: () {
                context.read<HomeBloc>().add(OnGetPosts());
                return Future.value();
              });
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
              ),
              onRefresh: () {
                context.read<HomeBloc>().add(OnGetPosts());
                return Future.value();
              }),
        );
      },
    );
  }
}
