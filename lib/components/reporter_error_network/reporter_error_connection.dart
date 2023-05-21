import 'dart:developer';

import 'package:rxdart/subjects.dart';

class ReporterErrorConnection {
  final BehaviorSubject<String> _reporterConnectionErrorStreamController =
      BehaviorSubject<String>.seeded("");

  Stream<String> getStreamReporter() {
    return _reporterConnectionErrorStreamController.stream;
  }

  void addNewValue(String? internetError) {
    if (internetError != null) {
      _reporterConnectionErrorStreamController.sink.add(internetError);
    }
  }

  Future<String> getLastMessageFromStream() async {
    try {
      if (_reporterConnectionErrorStreamController.hasValue) {
        String lastError =
            _reporterConnectionErrorStreamController.stream.value;

        return lastError;
      } else {
        return "";
      }
    } catch (e) {
      log("Error ${e.toString()}");
      return "";
    }
  }

  void dispose() {
    _reporterConnectionErrorStreamController.close();
  }

  ReporterErrorConnection._privateConstructor();
  static final ReporterErrorConnection _instance =
      ReporterErrorConnection._privateConstructor();
  static ReporterErrorConnection get instance => _instance;
}
