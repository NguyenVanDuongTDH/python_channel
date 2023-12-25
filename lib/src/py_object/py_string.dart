import '../pythonConfig.dart';

class PyString extends PyObjectType {
  PyString._({required super.reference});

  factory PyString.fromRef(Pointer<PyObject> ref) {
    return PyString._(reference: ref);
  }

  factory PyString.fromDart(String value) {
    final cString = value.toCString();
    final pyString = PyThon.cpython.PyUnicode_FromString(cString.cast());
    cString.free();
    return PyString._(reference: pyString);
  }

  @override
  String asDart() {
    return PyThon.cpython.PyUnicode_AsUTF8(reference).cast<Utf8>().toDartString();
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyUnicode_Type_.cast()) == 1;
  }
}

extension DartToPyThon on String {
  PyString toPyString() {
    return PyString.fromDart(this);
  }
}
