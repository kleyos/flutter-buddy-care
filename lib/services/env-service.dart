/// Service to get info current buildMode
class EnvService {
  /// Set this to true in *main_test.dart* to be able to make some specific conditions for integrational tests
  static bool runningByTestDriver = false;
  static BuildMode _buildMode = (() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.RELEASE;
    }

    var result = BuildMode.PROFILE;

    assert(() {
      result = BuildMode.DEBUG;
      return true;
    }());

    return result;
  }());

  static bool get inDebug => _buildMode == BuildMode.DEBUG;
  static bool get inRelease => _buildMode == BuildMode.RELEASE;
  static bool get inProfile => _buildMode == BuildMode.PROFILE;
}

enum BuildMode {
  RELEASE,
  PROFILE,
  DEBUG
}
