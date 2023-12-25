// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:python_channel/src/create/cpython.dart';
export 'src/create/py_thread.dart';
export 'src/py_object/py_bool.dart';
export 'src/py_object/py_bytes.dart';
export 'src/py_object/py_dict.dart';
export 'src/py_object/py_double.dart';
export 'src/py_object/py_int.dart';
export 'src/py_object/py_list.dart';
export 'src/py_object/py_module.dart';
export 'src/py_object/py_object_type.dart';
export 'src/py_object/py_string.dart';
export 'src/py_object/py_tuple.dart';
export 'src/c_object/c_bytes.dart';
export 'src/c_object/c_string.dart';

class PythonChannel {
  static Future<void> initialize(String shareLibrary,
      {String? pythonHome, List<String> pythonPath = const []}) async {
    await PyThon.initialize(shareLibrary,
        pythonHome: pythonHome, pythonPath: pythonPath);
  }

  static void finalize() {
    PyThon.finalize();
  }
}
