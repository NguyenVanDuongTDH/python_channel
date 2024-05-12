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

  static String getAppPath() {
    final appDirectory = Directory(Platform.resolvedExecutable).parent.path;
    return appDirectory;
  }

  static Future<void> initialize(String shareLib,
      {String? pythonHome, List<String>? pythonPath}) async {
    if (pythonHome != null) {
      await PythonChannelPlatform.instance.setenv("PYTHONHOME", pythonHome);
    }
    if (pythonPath != null) {
      await PythonChannelPlatform.instance
          .setenv("PYTHONPATH", pythonPath.join(";"));
    }

    _cpython = CPython(ffi.DynamicLibrary.open(shareLib));
    cpython.Py_Initialize();
  }

  static finalize() {
    cpython.Py_Finalize();
  }
}
