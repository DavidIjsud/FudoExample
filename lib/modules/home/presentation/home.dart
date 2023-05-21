import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fudo_test/components/reporter_error_network/reporter_error_connection.dart';
import 'package:fudo_test/modules/creation_post/presentation/post.page.dart';
import 'package:fudo_test/modules/home/presentation/bloc/events/posts_events.dart';
import 'package:fudo_test/modules/home/presentation/bloc/events/users_events.dart';
import 'package:fudo_test/modules/home/presentation/bloc/home_bloc.dart';
import 'package:fudo_test/modules/home/presentation/subpages/post.page.dart';
import 'package:fudo_test/modules/home/presentation/subpages/users.page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFudo extends StatefulWidget {
  const HomeFudo({super.key});

  @override
  State<HomeFudo> createState() => _HomeFudoState();
}

class _HomeFudoState extends State<HomeFudo> {
  late ValueNotifier<int> _indexSelectedBottomNavBarNotifier;
  final int _usersTabBottomNavBarSelected = 0;
  final int _postsTabBottomNavBarSelected = 1;
  @override
  void initState() {
    super.initState();
    _indexSelectedBottomNavBarNotifier =
        ValueNotifier(_usersTabBottomNavBarSelected);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _listenToTabSelectedBottomNavBar();
      _requestUsersAsDefault();
      _listenMessageFromConnectivity();
    });
  }

  _listenMessageFromConnectivity() {
    ReporterErrorConnection.instance.getStreamReporter().listen((message) {
      if (message.isNotEmpty) {
        _showSnackBar(message, Colors.red);
      }
    });
  }

  _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  _requestUsersAsDefault() {
    context.read<HomeBloc>().add(OnGetUsers());
  }

  _listenToTabSelectedBottomNavBar() {
    _indexSelectedBottomNavBarNotifier.addListener(() {
      if (_indexSelectedBottomNavBarNotifier.value ==
          _usersTabBottomNavBarSelected) {
        context.read<HomeBloc>().add(OnGetUsers());
      }

      if (_indexSelectedBottomNavBarNotifier.value ==
          _postsTabBottomNavBarSelected) {
        context.read<HomeBloc>().add(OnGetPosts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _indexSelectedBottomNavBarNotifier,
        builder: (_, indexSelectedBottomNavBar, Widget? w) {
          return Scaffold(
            floatingActionButton: indexSelectedBottomNavBar ==
                    _postsTabBottomNavBarSelected
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const PagePostAdd();
                      }));
                    },
                    child: const Icon(Icons.add),
                  )
                : Container(),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int indexSelected) {
                _indexSelectedBottomNavBarNotifier.value = indexSelected;
              },
              selectedItemColor: const Color(0xFF28B7AF),
              currentIndex: indexSelectedBottomNavBar,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user_sharp), label: "Usuarios"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.post_add), label: "Posts"),
              ],
            ),
            body: SafeArea(
                child: ValueListenableBuilder(
                    valueListenable: _indexSelectedBottomNavBarNotifier,
                    builder: (_, indexTabBottomNavBarSelected, Widget? w) {
                      return IndexedStack(
                        index: indexTabBottomNavBarSelected,
                        children: const [
                          UsersSubPage(),
                          PostPage(),
                        ],
                      );
                    })),
          );
        });
  }
}
