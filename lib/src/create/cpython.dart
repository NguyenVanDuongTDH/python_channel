// ignore_for_file: unused_element

import 'dart:io';
import 'dart:ffi' as ffi;

import 'package:flutter/material.dart';

import '../../python_channel_platform_interface.dart';
import '../pythonConfig.dart';

// CPython get cpython => PyThon._cpython!;

class PyThon {
  static CPython? _cpython;
  static CPython get cpython => _cpython!;
  static const List<String> _pythonPathWindows = [];

  static String getExePath() {
    final appDirectory = Directory(Platform.resolvedExecutable).parent.path;
    return appDirectory;
  }

  
  static Future<void> initialize(
      String shareLib, {String? pythonHome, List<String> pythonPath = const []}) async {
    WidgetsFlutterBinding.ensureInitialized();
    if(pythonHome != null) {
      await PythonChannelPlatform.instance.setenv("PYTHONHOME", pythonHome);
      await PythonChannelPlatform.instance.setenv("PYTHONPATH", "$pythonHome\\Lib\\site-packages");
    }
    
    _cpython = CPython(ffi.DynamicLibrary.open(shareLib));
    cpython.Py_Initialize();
  }

  static finalize() {
    cpython.Py_Finalize();
  }
}
