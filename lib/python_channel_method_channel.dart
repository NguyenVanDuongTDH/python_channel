import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'python_channel_platform_interface.dart';

/// An implementation of [PythonChannelPlatform] that uses method channels.
class MethodChannelPythonChannel extends PythonChannelPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('python_channel');

  @override
  Future<bool> setenv(String path, String env) async {
    final res =
        await methodChannel.invokeMethod("setenv", {"path": path, "env": env});
    return res == 0;
  }

}
