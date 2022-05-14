import 'package:dream/editor/models/node.dart';
import 'package:flutter/material.dart';

typedef OnTextChange = void Function(String text);

class SFTextWidget extends StatelessWidget {
  final SFNode node;
  final OnTextChange onChange;

  const SFTextWidget(this.node, this.onChange, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textNode = node as SFTextNode;
    final myController = TextEditingController()..text = textNode.content;
    myController.addListener(() {
      debugPrint('value change ' + myController.text);
      onChange(myController.text);
    });
    return TextField(
      decoration: const InputDecoration(
        hintText: '开始输入',
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: myController,
    );
  }
}
