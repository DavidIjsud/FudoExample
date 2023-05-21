import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_test/modules/creation_post/presentation/bloc/post_bloc.dart';

class PagePostAdd extends StatefulWidget {
  const PagePostAdd({super.key});

  @override
  State<PagePostAdd> createState() => _PostPageState();
}

class _PostPageState extends State<PagePostAdd> {
  late TextEditingController _titleController,
      _bodyController,
      _userIdController;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  _initControllers() {
    _titleController = TextEditingController(text: "");
    _bodyController = TextEditingController(text: "");
    _userIdController = TextEditingController(text: "");
  }

  _areFieldsFilled() {
    return _titleController.value.text.isNotEmpty &&
        _userIdController.value.text.isNotEmpty &&
        _bodyController.value.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Scaffold(
        bottomNavigationBar: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostPostedSuccessfull) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Post agregado satisfactoriamente",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )));
            }

            if (state is UnknowErrorOnPost) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Tuvimos un problema al agregar el post, intenta nuevamente",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )));
            }
          },
          builder: (context, state) {
            if (state is LoadingPost) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return InkWell(
              onTap: () {
                if (_areFieldsFilled()) {
                  context.read<PostBloc>().add(OnAddNewPost(
                        title: _titleController.value.text,
                        body: _bodyController.value.text,
                        userId: _userIdController.value.text,
                      ));
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Debes de llenar todos los campos"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _bodyController,
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "body",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _userIdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "UserID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
