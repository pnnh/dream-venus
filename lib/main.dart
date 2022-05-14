import 'dart:io' show Platform;

import 'package:dream/application/desktop/application.dart'
    if (dart.library.html) 'package:dream/application/web/application.dart'
    as application;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pillow/pillow.dart';

import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var platformName = '';
  if (kIsWeb) {
    platformName = "Web";
  } else {
    if (Platform.isAndroid) {
      platformName = "Android";
    } else if (Platform.isIOS) {
      platformName = "IOS";
    } else if (Platform.isLinux) {
      platformName = "Linux";
    } else if (Platform.isMacOS) {
      platformName = "MacOS";
    } else if (Platform.isWindows) {
      platformName = "Windows";
    }
  }
  debugPrint("platformName :- " + platformName.toString());

  await application.initApp();

  await Pillow.initPlugin(resUrl: getResUrl());
  runApp(const application.Application());
}
