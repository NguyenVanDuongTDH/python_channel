// ignore_for_file: no_leading_underscores_for_local_identifiers

import '../pythonConfig.dart';

class PyModule extends PyObjectType {
  PyModule._({required super.reference});

  factory PyModule.open(String module) {
    CString cModule = module.toCString();
    final pModlue = PyThon.cpython.PyImport_ImportModule(cModule.cast());
    cModule.free();
    return PyModule._(reference: pModlue);
  }

  factory PyModule.create(String newModule, {String? code}) {
    final pModlue =
        PyThon.cpython.PyModule_NewObject(newModule.toPyString().reference);

    final module = PyModule._(reference: pModlue);
    if (code != null) {
      module.exec(code);
    }
    return module;
  }

  factory PyModule.fromRef(Pointer<PyObject> ref) {
    return PyModule._(reference: ref);
  }

  @override
  PyObjectType attr(String name) {
    int oldRef = reference.ref.ob_refcnt;
    if (reference == nullptr) {
      throw ("Module nullptr");
    } else {
      final _name = name.toCString();
      int check = PyThon.cpython.PyObject_HasAttrString(reference, _name.cast());
      if (check <= 0) {
        throw ("attr $name null");
      }
      final res = PyThon.cpython.PyObject_GetAttrString(reference, _name.cast());
      _name.free();
      if (oldRef < reference.ref.ob_refcnt) {
        dec_ref();
      }
      PyThon.cpython.Py_DecRef(res);
      return PyObjectType(reference: res);
    }
  }

  void exec(String code) {
    if (reference == nullptr) {
      throw ("Module nullptr");
    } else {
      final _code = code.toCString();
      PyThon.cpython.PyRun_String(
          _code.cast(), Py_file_input, attr("__dict__").reference, nullptr);
      _code.free();
    }
  }
}
