
import '../pythonConfig.dart';

class CObject {
  Pointer reference;
  CObject(this.reference);
  void free() {
    calloc.free(reference);
  }

  Pointer<U> cast<U extends NativeType>() {
    return reference.cast();
  }
}
