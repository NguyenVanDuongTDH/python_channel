import '../pythonConfig.dart';

class CBytes extends CObject {
  CBytes._(super.reference);
  factory CBytes.fromUint8List(Uint8List uList) {
    Pointer<Uint8> cBytes = calloc.allocate<Uint8>(uList.length);
    cBytes.asTypedList(uList.length).setAll(0, uList);
    return CBytes._(cBytes);
  }
  Uint8List toUint8List(int length) {
    return Uint8List.fromList(reference.cast<Uint8>().asTypedList(length));
  }
}

extension DARTSTRINGTOC_CBytes on Uint8List{
  CBytes toCBytes(){
    return CBytes.fromUint8List(this);
  }
}
