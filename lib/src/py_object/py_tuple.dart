import '../pythonConfig.dart';

class PyTuple extends PyObjectType {
  PyTuple._({required super.reference});

  factory PyTuple.fromRef(Pointer<PyObject> ref) {
    return PyTuple._(reference: ref);
  }

  factory PyTuple.fromDart(List list) {
    
    PyList pyList = list.toPyList();
    final res = PyTuple._(
        reference: PyThon.cpython.PyList_AsTuple(pyList.reference));
    pyList.dec_ref();
    return res;
  }
  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyTuple_Type_.cast()) == 1;
  }
}

extension ListToPyTuple on List {
  PyTuple toPyTuple() {
    return PyTuple.fromDart(this);
  }
}
