// import 'package:flutter_test/flutter_test.dart';
// import 'package:python_channel/python_channel.dart';
// import 'package:python_channel/python_channel_platform_interface.dart';
// import 'package:python_channel/python_channel_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockPythonChannelPlatform
//     with MockPlatformInterfaceMixin
//     implements PythonChannelPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final PythonChannelPlatform initialPlatform = PythonChannelPlatform.instance;

//   test('$MethodChannelPythonChannel is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelPythonChannel>());
//   });

//   test('getPlatformVersion', () async {
//     PythonChannel pythonChannelPlugin = PythonChannel();
//     MockPythonChannelPlatform fakePlatform = MockPythonChannelPlatform();
//     PythonChannelPlatform.instance = fakePlatform;

//     expect(await pythonChannelPlugin.getPlatformVersion(), '42');
//   });
// }
