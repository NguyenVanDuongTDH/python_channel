// ignore_for_file: no_leading_underscores_for_local_identifiers

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

  PyObjectType operator [](String key) {
    final _key = key.toCString();
    final res = PyThon.cpython.PyDict_GetItemString(reference, _key.cast());
    _key.free();
    return PyObjectType(reference: res);
  }

  void operator []=(String key, dynamic value) {
    CString cKey = key.toCString();
    PyThon.cpython.PyDict_SetItemString(
        reference, cKey.cast(), PyObjectType.formDart(value).reference);
    cKey.free();
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

  int remove(String key) {
    final _key = CString.fromString(key);
    int res = PyThon.cpython.PyDict_DelItemString(reference, _key.cast());
    _key.free();
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

      // PyThon.cpython.Py_DecRef(pyKey.reference);
      // PyThon.cpython.Py_DecRef(pValue.reference);
    }
    calloc.free(key);
    calloc.free(value);

    return map;
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyDict_Type_.cast()) == 1;
  }

  bool contains(String key) {
    return PyThon.cpython.PyDict_Contains(reference, key.toPyString().reference) == 1;
  }
}

extension MapPyObjectToPython on Map<String, dynamic> {
  PyDict toPyDict() {
    return PyDict.fromMap(this);
  }
}
