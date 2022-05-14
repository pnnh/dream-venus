import 'package:dream/editor/models/node.dart';
import 'package:flutter/material.dart';

class SFEditorState with ChangeNotifier {
  int value = 0;

  List<SFNode> children = [SFTextNode('我是一个文本节点')];

  void increment() {
    value += 1;
    notifyListeners();
  }

  void insertNode(int index, SFNode node) {
    children.insert(index, node);
    notifyListeners();
  }
}

class RowState with ChangeNotifier {
  bool show;
  int index;

  RowState(this.index, this.show);

  void setShow(bool show) {
    this.show = show;
    notifyListeners();
  }
}
