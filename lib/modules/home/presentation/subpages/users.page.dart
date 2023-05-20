import 'package:flutter/material.dart';
import 'package:fudo_test/modules/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_test/modules/home/presentation/bloc/states/users_states.dart';

class UsersSubPage extends StatefulWidget {
  const UsersSubPage({super.key});

  @override
  State<UsersSubPage> createState() => _UsersSubPageState();
}

class _UsersSubPageState extends State<UsersSubPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          current is SlowInternetUsersState ||
          current is NoInternetUsersState ||
          current is UnknowErrorUsers,
      listener: (_, state) {
        if (state is UnknowErrorUsers) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Tuvimos un problema al obtener los posts",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state is NoInternetUsersState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Conectate a internet",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (state is SlowInternetUsersState) {
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
          current is LoadingUsers || current is UsersGotSuccessfull,
      builder: (context, state) {
        if (state is UsersGotSuccessfull) {
          return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (_, indexInPostList) {
                return ListTile(
                  title: Text(state.users[indexInPostList].name),
                  subtitle: Text(state.users[indexInPostList].username),
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
