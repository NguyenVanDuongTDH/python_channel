import '../pythonConfig.dart';

class PyBytes extends PyObjectType {
  PyBytes._({required super.reference});

  factory PyBytes.fromRef(Pointer<PyObject> ref) {
    return PyBytes._(reference: ref);
  }

  factory PyBytes.fromDart(Uint8List bytes) {
    CBytes cBytes = CBytes.fromUint8List(bytes);
    Pointer<PyObject> reference =
        PyThon.cpython.PyBytes_FromStringAndSize(cBytes.cast(), bytes.length);
    cBytes.free();
    return PyBytes._(reference: reference);
  }

  @override
  Uint8List asDart() {
    Pointer<Pointer<Uint8>> char = calloc.allocate(sizeOf<Pointer<Char>>());
    Pointer<Long> len = calloc.allocate(sizeOf<Long>());
    PyThon.cpython.PyBytes_AsStringAndSize(reference, char.cast(), len);

    Uint8List uint8List = Uint8List.fromList(char.value.asTypedList(len.value));

    calloc.free(len);
    calloc.free(char);

    return uint8List;
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyBytes_Type_.cast()) == 1;
  }
}

extension Uint8ListToPyBytes on Uint8List {
  PyBytes toPyBytes() {
    return PyBytes.fromDart(this);
  }
}
