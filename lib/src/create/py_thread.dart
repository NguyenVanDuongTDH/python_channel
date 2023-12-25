// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_nullable

import '../pythonConfig.dart';

class PyThread {
  static PyModule? _pyThread;
  PyObjectType target;
  List? args;
  String? address;
  static int _countThread = 0;

  PyThread({
    required this.target,
    this.args,
  }) {
    if (_pyThread == null) {
      create();
    }
  }

  void start() {
    address = _pyThread!.attr("runThread").call([target, args]).cast();
  }

  void joinAsync() {
    final dict = _pyThread!.attr("ThreadResultMap").cast<PyDict>();
    while (!dict.contains(address!)) {
      _pyThread!.attr("t").call();
    }
  }

  Future<void> join() async {
    _beginThread();
    final dict = _pyThread!.attr("ThreadResultMap").cast<PyDict>();
    while (!dict.contains(address!)) {
      await Future.delayed(const Duration(milliseconds: 1));
      _pyThread!.attr("t").call();
    }
    _endThread();
  }

  PyObjectType result() {
    final dict = _pyThread!.attr("ThreadResultMap").cast<PyDict>();
    final res = dict[address!];
    res.inc_ref();
    dict.remove(address!);
    return PyObjectType(reference: res.reference);
  }

  static Future<void> _runPythonLoop() async {
    while (_countThread > 0) {
      await Future.delayed(const Duration(milliseconds: 1));
      _pyThread!.attr("t").call();
    }
  }

  static _beginThread() {
    _countThread++;
    _runPythonLoop();
  }

  static _endThread() {
    _countThread--;
  }

  static void create() {
    _pyThread ??= PyModule.create("PyThread");
    _pyThread!.exec("""
import time
import random
import threading

def t():
    pass
ThreadResultMap = {}

_countThread = 0;
def runThread(target, args=None):
    global _countThread
    result = str(_countThread)
    _countThread = _countThread + 1
    def run(target, args):
        ThreadResultMap[result] = target(*args)
    thread = threading.Thread(target=run, args=(target, args))
    thread.start()
    return result

""");
  }

}
