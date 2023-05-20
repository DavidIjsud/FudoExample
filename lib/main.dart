import 'package:flutter/material.dart';
import 'package:fudo_test/environments/enviroment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    return MaterialApp(
      title: 'Presto Latam',
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
