import '../pythonConfig.dart';

class PyList extends PyObjectType {
  PyList._({required super.reference});

  factory PyList.fromRef(Pointer<PyObject> ref) {
    return PyList._(reference: ref);
  }

  factory PyList.fromDart(List list) {
    var pyList = PyThon.cpython.PyList_New(0);
    for (var item in list) {
      if (item is PyObjectType) {
        PyThon.cpython.PyList_Append(pyList, item.reference);
      } else {
        final pyItem = PyObjectType.formDart(item);
        PyThon.cpython.PyList_Append(pyList, pyItem.reference);
        pyItem.dec_ref();
      }
    }
    return PyList._(reference: pyList);
  }

  int get lenght => PyThon.cpython.PyList_Size(reference);


  void add(dynamic item) {
    PyThon.cpython.PyList_Append(reference, PyObjectType.formDart(item).reference);
  }

  @override
  List asDart() {
    PyList pyList = PyList.fromRef(reference);
    List dartList = [];
    for (int i = 0; i < lenght; i++) {
      dartList.add(pyList[i].asDart());
    }
    return dartList;
  }

  int get length => PyThon.cpython.PyList_Size(reference);

  PyObjectType operator [](int index) {
    return PyThon.cpython.PyList_GetItem(reference, index).toPyObjectType();
  }

  void operator []=(int index, dynamic value) {
    PyThon.cpython.PyList_SetItem(
        reference, index, PyObjectType.formDart(value).reference);
  }

  static bool check(Pointer<PyObject> ref) {
    return PyThon.cpython.PyObject_IsInstance(ref, PyThon.cpython.PyList_Type_.cast()) == 1;
  }

  int removeAt(int index) {
    return PyThon.cpython.PySequence_DelItem(reference, index);
  }

  void clear() {
    PyThon.cpython.PyList_SetSlice(reference, 0, length, nullptr);
  }

  bool get isEmpty => length == 0;
}

extension ListToPython on List {
  PyList toPyList() {
    return PyList.fromDart(this);
  }
}
