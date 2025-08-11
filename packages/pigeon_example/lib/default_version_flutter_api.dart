import 'package:pigeon_example/platform.g.dart';

// Flutter interface implementation
class DefaultVersionFlutterApi extends VersionFlutterApi {
  @override
  String getAppVersion() => "1.0.0";
}