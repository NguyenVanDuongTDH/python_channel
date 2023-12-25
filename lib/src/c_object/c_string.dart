import '../pythonConfig.dart';

class CString extends CObject {
  CString._(Pointer reference) : super(reference);
  factory CString.fromString(String str, {String mode = "utf-8"}) {
    if (mode == "utf-8") {
      return CString._(str.toNativeUtf8());
    } else if (mode == "utf-16") {
      return CString._(str.toNativeUtf16());
    } else {
      throw ("invalid mode");
    }
  }

  String toDartString({String mode = "utf-8"}) {
    if (mode == "utf-8") {
      return reference.cast<Utf8>().toDartString();
    } else if (mode == "utf-16") {
      return reference.cast<Utf16>().toDartString();
    }
    return throw ("Invalid mode");
  }
}

extension DARTSTRINGTOC on String {
  CString toCString() {
    return CString.fromString(this);
  }
}
