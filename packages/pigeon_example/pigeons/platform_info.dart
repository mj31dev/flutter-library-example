import 'package:pigeon/pigeon.dart';

// Pigeon configuration
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
// Model configuration
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
// Native interface configuration
abstract class PlatformInfoApi {
  @async
  PlatformInfo getPlatformInfo();
}

@FlutterApi()
// Flutter interface configuration
abstract class VersionFlutterApi {
  String getAppVersion();
}
