import 'package:dream/editor/models/node.dart';
import 'package:dream/editor/models/states.dart';
import 'package:dream/editor/nodes/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'plus.dart';

class SFRowWidget extends StatelessWidget {
  final SFNode node;
  final int index;

  const SFRowWidget(this.index, this.node, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RowState(index, false),
      child: SFRow(node),
    );
  }
}

class SFRow extends StatelessWidget {
  final SFNode node;

  const SFRow(this.node, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SFPlus(),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              children: [renderNode(node)],
            ),
          )
        ],
      ),
      onEnter: (event) {
        var state = context.read<RowState>();
        state.setShow(true);
      },
      onExit: (event) {
        var state = context.read<RowState>();
        state.setShow(false);
      },
    );
  }
}

Widget renderNode(SFNode node) {
  switch (node.runtimeType) {
    case SFTextNode:
      return SFTextWidget(node, (text) => (node as SFTextNode).onChange(text));
  }
  return const Text('未知节点');
}
