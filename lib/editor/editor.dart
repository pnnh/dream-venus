import 'package:dream/editor/models/node.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/states.dart';
import 'nodes/row.dart';

typedef OnPress = void Function();

class SFEditorRoute extends StatelessWidget {
  const SFEditorRoute({Key? key}) : super(key: key);

  List<Widget> buildChildren(BuildContext context, List<SFNode> children) {
    var result = List<Widget>.empty(growable: true);
    for (var i = 0; i < children.length; i++) {
      var node = children[i];
      var row = SFRowWidget(i, node);
      result.add(row);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => SFEditorState())],
      child: Container(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Consumer<SFEditorState>(
              builder: (context, state, child) => Column(
                children: buildChildren(context, state.children),
              ),
            )),
      ),
    );
  }
}
