import 'package:dream/editor/models/node.dart';
import 'package:dream/editor/models/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SFPlus extends StatelessWidget {
  const SFPlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RowState>(
        builder: (context, state, child) => SizedBox(
              height: 48,
              width: 96,
              child: state.show
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 24,
                            constraints: const BoxConstraints(
                                maxHeight: 24, maxWidth: 24),
                            padding: EdgeInsets.zero,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onPressed: () {
                              var node = SFTextNode('content + ');
                              var editorState = context.read<SFEditorState>();
                              editorState.insertNode(state.index + 1, node);
                            },
                            icon: const Icon(Icons.add)),
                        IconButton(
                            iconSize: 24,
                            constraints: const BoxConstraints(
                                maxHeight: 24, maxWidth: 24),
                            padding: EdgeInsets.zero,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onPressed: () {},
                            icon: const Icon(Icons.article)),
                        PopupMenuButton(
                            initialValue: '语文',
                            itemBuilder: (context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: '语文',
                                  child: Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text('一号标题')),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text('二号标题'))
                                    ],
                                  ),
                                ),
                              ];
                            })
                      ],
                    )
                  : null,
            ));
  }
}
