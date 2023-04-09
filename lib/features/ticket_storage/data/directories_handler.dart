import 'package:path_provider/path_provider.dart';

// create interface
class DirectoriesHandler {

  Future<String> getAppDocumentsDirectory() async {
    return (await (getApplicationDocumentsDirectory())).path;
  }
}