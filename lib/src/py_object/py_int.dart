import '../pythonConfig.dart';

class PyInt extends PyObjectType {
  PyInt._({required super.reference});

  factory PyInt.fromRef(Pointer<PyObject> ref) {
    return PyInt._(reference: ref);
  }

  factory PyInt.fromDart(int value) {
    return PyInt._(reference: PyThon.cpython.PyLong_FromLongLong(value));
    // return PyInt._(reference: PyThon.cpython.PyLong_FromLong(value));
  }

  @override
  int asDart() {
    return PyThon.cpython.PyLong_AsLongLong(reference);
    // return PyThon.cpython.PyLong_AsLong(reference);
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython
            .PyObject_IsInstance(ref, PyThon.cpython.PyLong_Type_.cast()) ==
        1;
  }
}

extension IntToPyInt on int {
  PyInt toPyInt() {
    return PyInt.fromDart(this);
  }
}
