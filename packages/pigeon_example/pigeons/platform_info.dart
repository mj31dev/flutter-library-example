import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/platform.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/dsr_corporation/pigeon_example/Platform.g.kt',
    kotlinOptions: KotlinOptions(),
    swiftOut: 'ios/Classes/Platform.g.swift',
    swiftOptions: SwiftOptions(),
    dartPackageName: 'pigeon_example',
  ),
)
class PlatformInfo {
  PlatformInfo({
    required this.name,
    required this.version,
    required this.appVersion,
  });

  String name;
  String version;
  String appVersion;
}

@HostApi()
abstract class PlatformInfoApi {
  @async
  PlatformInfo getPlatformInfo();
}

@FlutterApi()
abstract class VersionFlutterApi {
  String getAppVersion();
}
