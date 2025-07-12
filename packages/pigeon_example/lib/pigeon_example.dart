import 'package:pigeon_example/default_version_flutter_api.dart';

import 'platform.g.dart';

class PigeonExample {
  final _api = PlatformInfoApi();

  PigeonExample() {
    VersionFlutterApi.setUp(DefaultVersionFlutterApi());
  }

  Future<PlatformInfo> getPlatformInfo() {
    return _api.getPlatformInfo();
  }
}
