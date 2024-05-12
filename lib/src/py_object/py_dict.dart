// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:python_channel/python_channel.dart';

import '../pythonConfig.dart';

class PyDict extends PyObjectType {
  PyDict._({required super.reference});

  factory PyDict.fromRef(Pointer<PyObject> ref) {
    return PyDict._(reference: ref);
  }

  factory PyDict.fromMap(Map<String, dynamic> map) {
    Pointer<PyObject> dict = PyThon.cpython.PyDict_New();
    map.forEach((key, value) {
      CString cKey = key.toCString();
      PyThon.cpython.PyDict_SetItemString(
          dict, cKey.cast(), PyObjectType.formDart(value).reference);
      cKey.free();
    });

    return PyDict._(reference: dict);
  }

  PyObjectType operator [](dynamic key) {
    PyObjectType _key;
    key is PyObjectType ? _key = key : _key = PyObjectType.formDart(key);
    final check =
        PyThon.cpython.PyDict_Contains(reference, _key.reference.cast());
    if (check == 0) {
      return PyThon.cpython.Py_NoneStruct.toPyObjectType();
    }
    final res = PyThon.cpython.PyDict_GetItem(reference, _key.reference.cast());
    if (key is! PyObjectType) {
      _key.dec_ref();
    }

    return PyObjectType(reference: res);
  }

  operator []=(dynamic key, dynamic value) {
    PyObjectType _key;
    key is PyObjectType ? _key = key : _key = PyObjectType.formDart(key);
    final res = PyThon.cpython.PyDict_SetItem(reference, _key.reference.cast(),
        PyObjectType.formDart(value).reference);
    if (key is! PyObjectType) {
      _key.dec_ref();
    }
  }

  PyList keys() {
    final res = PyThon.cpython.PyDict_Keys(reference);
    return PyList.fromRef(res);
  }

  bool contains(dynamic key) {
    PyObjectType _key;
    key is PyObjectType ? _key = key : _key = PyObjectType.formDart(key);
    final res =
        PyThon.cpython.PyDict_Contains(reference, _key.reference.cast());
    if (key is! PyObjectType) {
      _key.dec_ref();
    }
    return res == 1;
  }

  void exec(String code) {
    CString _code = CString.fromString(code);
    PyThon.cpython.PyRun_String(_code.cast(), 257, reference, reference);
    _code.free();
  }

  int get length => PyThon.cpython.PyDict_Size(reference);

  void clear() {
    PyThon.cpython.PyDict_Clear(reference);
  }

  int remove(dynamic key) {
    PyObjectType _key;
    key is PyObjectType ? _key = key : _key = PyObjectType.formDart(key);
    int res = PyThon.cpython.PyDict_DelItem(reference, _key.reference.cast());
    if (key is! PyObjectType) {
      _key.dec_ref();
    }
    return res;
  }

  @override
  Map<String, dynamic> asDart() {
    Map<String, dynamic> map = {};

    Pointer<Pointer<PyObject>> key =
        calloc.allocate(sizeOf<Pointer<Pointer<PyObject>>>());
    Pointer<Pointer<PyObject>> value =
        calloc.allocate(sizeOf<Pointer<Pointer<PyObject>>>());
    Pointer<Py_ssize_t> pos = calloc.allocate(sizeOf<Pointer<Py_ssize_t>>());

    while (PyThon.cpython.PyDict_Next(reference, pos, key, value) == 1) {
      final pyKey = key.value.toPyObjectType();
      final pValue = value.value.toPyObjectType();
      map[pyKey.cast<String>()] = pValue.asDart();
    }
    calloc.free(key);
    calloc.free(value);
    return map;
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython
            .PyObject_IsInstance(ref, PyThon.cpython.PyDict_Type_.cast()) ==
        1;
  }
}

extension MapPyObjectToPython on Map<String, dynamic> {
  PyDict toPyDict() {
    return PyDict.fromMap(this);
  }
}
