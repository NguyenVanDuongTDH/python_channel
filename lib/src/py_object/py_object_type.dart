// ignore_for_file: non_constant_identifier_names, unused_element, no_leading_underscores_for_local_identifiers

import '../create/py_thread.dart';
import '../pythonConfig.dart';

class PyObjectType {
  Pointer<PyObject> reference;

  PyObjectType({
    required this.reference,
  });

  factory PyObjectType.fromRef(Pointer<PyObject> ref) {
    return PyObjectType(reference: ref);
  }

  static PyObjectType formDart(dynamic item) {
    if (item is String) {
      return item.toPyString();
    } else if (item is int) {
      return item.toPyInt();
    } else if (item is double) {
      return item.toPyDouble();
    } else if (item is Uint8List) {
      return item.toPyBytes();
    } else if (item is List) {
      return item.toPyList();
    } else if (item is PyObjectType) {
      return item;
    } else if (item is Pointer<PyObject>) {
      return item.toPyObjectType();
    } else if (item is Map<String, dynamic>) {
      return PyDict.fromMap(item);
    } else if (item is bool) {
      return PyBool.fromDart(item);
    } else if (item == null) {
      return PyThon.cpython.Py_NoneStruct.toPyObjectType();
    } else {
      throw ("not supporte");
    }
  }

  factory PyObjectType.fromDart(dynamic item) {
    dynamic obj;

    return PyObjectType(reference: obj);
  }

  void inc_ref() {
    PyThon.cpython.Py_IncRef(reference);
  }

  void dec_ref() {
    PyThon.cpython.Py_DecRef(reference);
  }

  bool isNone() {
    return PyThon.cpython.Py_IsNone(reference) == 1;
  }

  @override
  String toString() {
    return asDart().toString();
  }

  PyObjectType call([List? args]) {
    int oldRef = reference.ref.ob_refcnt;
    final _args = PyTuple.fromDart(args ?? []);
    final res = PyThon.cpython.PyObject_CallObject(reference, _args.reference);
    if (oldRef < reference.ref.ob_refcnt) {
      dec_ref();
    }
    _args.dec_ref();
    return PyObjectType(reference: res).cast();
  }

  Future<PyObjectType> callThread([List? args]) async {
    int oldRef = reference.ref.ob_refcnt;
    final thread =
        PyThread(target: reference.toPyObjectType(), args: args ?? []);
    thread.start();
    await thread.join();
    if (oldRef < reference.ref.ob_refcnt) {
      dec_ref();
    }
    return thread.result();
  }

  PyObjectType attr(String name) {
    int oldRef = reference.ref.ob_refcnt;
    if (reference == nullptr) {
      throw ("Module nullptr");
    } else {
      final _name = name.toCString();
      int check =
          PyThon.cpython.PyObject_HasAttrString(reference, _name.cast());
      if (check <= 0) {
        throw ("attr $name null");
      }

      final res =
          PyThon.cpython.PyObject_GetAttrString(reference, _name.cast());
      if (oldRef < reference.ref.ob_refcnt) {
        dec_ref();
      }
      _name.free();
      return PyObjectType(reference: res);
    }
  }

  U cast<U>() {
    switch (U) {
      case PyInt:
        return PyInt.fromRef(reference) as U;
      case PyDouble:
        return PyDouble.fromRef(reference) as U;
      case PyString:
        return PyString.fromRef(reference) as U;
      case PyBytes:
        return PyBytes.fromRef(reference) as U;
      case PyList:
        return PyList.fromRef(reference) as U;
      case PyTuple:
        return PyTuple.fromRef(reference) as U;
      case PyModule:
        return PyModule.fromRef(reference) as U;
      case PyDict:
        return PyDict.fromRef(reference) as U;
      case PyBool:
        return PyBool.fromRef(reference) as U;
      case PyObjectType:
        return PyObjectType.fromRef(reference) as U;
      default:
        return asDart() as U;
    }
  }

  dynamic asDart() {
    if (PyBool.check(reference)) {
      return cast<PyBool>().asDart();
    } else if (PyInt.check(reference)) {
      return cast<PyInt>().asDart();
    } else if (PyDouble.check(reference)) {
      return cast<PyDouble>().asDart();
    } else if (PyString.check(reference)) {
      return cast<PyString>().asDart();
    } else if (PyBytes.check(reference)) {
      return cast<PyBytes>().asDart();
    } else if (PyList.check(reference)) {
      return cast<PyList>().asDart();
    } else if (PyDict.check(reference)) {
      return cast<PyDict>().asDart();
    } else if (reference.address == PyThon.cpython.Py_NoneStruct.address) {
      return null;
    }
    throw UnimplementedError();
  }
}

extension PointerPyObjectToPython on Pointer<PyObject> {
  PyObjectType toPyObjectType() {
    return PyObjectType.fromRef(this);
  }
}
