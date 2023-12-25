import '../pythonConfig.dart';

class PyDouble extends PyObjectType {
  PyDouble._({required super.reference});

  factory PyDouble.fromRef(Pointer<PyObject> ref) {
    return PyDouble._(reference: ref);
  }

  factory PyDouble.fromDart(double value) {
    return PyDouble._(reference: PyThon.cpython.PyFloat_FromDouble(value));
  }

  @override
  double asDart() {
    return PyThon.cpython.PyFloat_AsDouble(reference);
  }


  static bool check(Pointer<PyObject> ref){
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyFloat_Type_.cast()) == 1;
  }
}

extension IntToPyDouble on double {
  PyDouble toPyDouble() {
    return PyDouble.fromDart(this);
  }
}
