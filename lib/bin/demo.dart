import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

import 'package:path/path.dart' as path;

typedef HelloWorldFunc = ffi.Void Function();
typedef HelloWorld = void Function();

void main() {
  var libraryPath =
      path.join(Directory.current.path, 'common/lib', 'libhello.so');
  if (Platform.isMacOS) {
    libraryPath =
        path.join(Directory.current.path, 'common/lib', 'libhello.dylib');
  }

  final dylib = ffi.DynamicLibrary.open(libraryPath);

  final HelloWorld hello = dylib
      .lookup<ffi.NativeFunction<HelloWorldFunc>>('hello_world')
      .asFunction();
  hello();
}
