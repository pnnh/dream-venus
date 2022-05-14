import 'package:flutter/foundation.dart';

class SFNode {
  String type = 'text';

  SFNode(this.type);
}

class SFTextNode extends SFNode {
  String content;

  SFTextNode(this.content) : super('text');

  void onChange(String text) {
    debugPrint('onchange $text');
    content = text;
  }
}
