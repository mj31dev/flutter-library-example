import 'package:pigeon_example/default_version_flutter_api.dart';

import 'platform.g.dart';

class PigeonExample {
  // Generated api
  final _api = PlatformInfoApi();

  PigeonExample() {
    // Setup flutter interface implementation
    VersionFlutterApi.setUp(DefaultVersionFlutterApi());
  }

  // Get platform information
  Future<PlatformInfo> getPlatformInfo() {
    return _api.getPlatformInfo();
  }
}
