import 'dart:ffi';
import 'dart:io' show Directory, Platform;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

class payload_t extends Struct {
  external Pointer<Utf8> data;

  @Int32()
  external int len;
}

typedef post_imageNative = Int32 Function(
    Pointer<Utf8> c_url, Pointer<payload_t> payload_ptr);
typedef post_image = int Function(
    Pointer<Utf8> c_url, Pointer<payload_t> payload_ptr);

void main() {
  // Open the dynamic library
  var libraryPath =
      path.join(Directory.current.path, 'common/lib', 'libhello_wasm.so');
  if (Platform.isMacOS) {
    libraryPath =
        path.join(Directory.current.path, 'common/lib', 'libhello_wasm.dylib');
  }
  final dylib = DynamicLibrary.open(libraryPath);

  final url = 'http://localhost:8080'.toNativeUtf8();
  final myHomeUtf8 = 'My 默认初始结构值在分配 #43596 上未初始化'.toNativeUtf8();
  final payload = malloc<payload_t>();
  final payloadRef = payload.ref;
  payloadRef.data = myHomeUtf8;
  payloadRef.len = myHomeUtf8.length;

  final postImage =
      dylib.lookupFunction<post_imageNative, post_image>('post_image');

  final coordinate = postImage(url, payload);
}
