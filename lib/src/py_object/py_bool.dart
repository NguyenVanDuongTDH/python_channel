import '../pythonConfig.dart';

class PyBool extends PyObjectType {
  PyBool._({required super.reference});

  factory PyBool.fromDart(bool value) {
    return PyBool._(
      reference:
          value ? PyThon.cpython.Py_TrueStruct.cast() : PyThon.cpython.Py_FalseStruct.cast(),
    );
  }
  factory PyBool.fromRef(Pointer<PyObject> ref) {
    return PyBool._(reference: ref);
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyBool_Type.cast()) == 1;
  }

  @override
  bool asDart() {
    return reference.address == PyThon.cpython.Py_TrueStruct.address;
  }



}

extension BoolToPython on bool {
  PyBool toPyBool() {
    return PyBool.fromDart(this);
  }
}
