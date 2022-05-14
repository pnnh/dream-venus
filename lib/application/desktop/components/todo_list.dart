import 'package:dream/application/desktop/components/todo_item.dart';
import 'package:dream/application/desktop/components/work_body.dart';
import 'package:dream/application/desktop/provider/home.dart';
import 'package:dream/application/desktop/provider/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'empty.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListWidget();
}

class _TodoListWidget extends State<TodoListWidget> {
  final Color selectedColor = const Color.fromRGBO(238, 243, 254, 100);
  final Color defaultColor = Colors.white;
  final Color iconColor = const Color.fromRGBO(153, 153, 153, 100);
  final contentController = TextEditingController(text: "啊啊啊啊啊啊");
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final todoListModel = Provider.of<TodoProvider>(context);
    var items = todoListModel.items.values.toList();
    debugPrint("TodoListWidget build ${items.length}");
    final currentItem = todoListModel.currentItem;
    final homeProvider = Provider.of<HomeProvider>(context);

    return Expanded(
        child: Row(
      children: [
        Container(
            width: 360,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
              color: Color.fromRGBO(229, 229, 229, 100),
              width: 1,
            ))),
            child: Column(
              children: [
                Row(children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        homeProvider.showFilter
                            ? "images/svg/menu_unfold.svg"
                            : "images/svg/menu_fold.svg",
                        color: const Color.fromRGBO(153, 153, 153, 100),
                      ),
                      iconSize: 24,
                      onPressed: () {
                        homeProvider.switchFilter();
                      }),
                  const Text("收集箱",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ))
                ]),
                const SizedBox(height: 16),
                SizedBox(
                    height: 40,
                    child: TextField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      minLines: 1,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: "回车创建笔记",
                          contentPadding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                          filled: true,
                          fillColor: const Color.fromRGBO(242, 242, 242, 100),
                          hoverColor: const Color.fromRGBO(242, 242, 242, 100)),
                      keyboardType: TextInputType.number,
                      controller: contentController,
                      onSubmitted: (text) {
                        debugPrint("Go button is clicked $text");
                        todoListModel.addItem(text, "");
                        contentController.text = "";
                        myFocusNode.requestFocus();
                      },
                      onChanged: (text) {
                        debugPrint("onChanged $text");
                      },
                    )),
                const SizedBox(height: 16),
                Expanded(
                    child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    if (items.length <= index) {
                      throw Exception("找不到item");
                    }
                    var item = items[index];
                    return TodoItemWidget(
                      task: item.task,
                      controller: item.controller,
                    );
                  },
                ))
              ],
            )),
        Expanded(
            child: Container(
                color: Colors.white,
                child: currentItem != null
                    ? WorkBodyWidget(
                        task: currentItem.task,
                        controller: currentItem.controller)
                    : const EmptyWidget(message: "点击左侧标题查看详情")))
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }
}
