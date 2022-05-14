import 'package:dream/application/desktop/provider/home.dart';
import 'package:dream/application/desktop/provider/todo.dart';
import 'package:dream/services/models/task.dart';
import 'package:dream/widgets/datepicker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WorkBodyWidget extends StatefulWidget {
  final Task task;
  final TextEditingController controller;

  const WorkBodyWidget({Key? key, required this.task, required this.controller})
      : super(key: key);

  @override
  State<WorkBodyWidget> createState() => _WorkBodyWidgetState();
}

class _WorkBodyWidgetState extends State<WorkBodyWidget> {
  final Color selectedColor = const Color.fromRGBO(0, 119, 212, 100);
  final Color defaultColor = const Color.fromRGBO(146, 148, 152, 100);
  final bodyController = TextEditingController();
  double sourceHeight = 240;
  bool isDragging = false;

  GestureDragUpdateCallback? dragCallback = null;
  GestureDragEndCallback? dragEndCallback = null;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    //final bodyProvider = Provider.of<BodyProvider>(context);
    bodyController.text = widget.task.body;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(children: [
            SizedBox(
                height: 32,
                child: Row(children: [
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        "images/svg/calendar_2.svg",
                        color: const Color.fromRGBO(153, 153, 153, 100),
                      )),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text("设置提醒",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        homeProvider.switchDatePicker();
                      });
                    },
                  ),
                ])),
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(4),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                hintText: "任务标题",
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              controller: widget.controller,
              onChanged: (text) {
                todoProvider.putItem(widget.task.key, text, widget.task.body);
              },
            ),
            const SizedBox(height: 24),
            Expanded(
                child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      height: sourceHeight,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: null,
                        maxLines: null,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          hintText: "任务正文",
                        ),
                        controller: bodyController,
                        onChanged: (text) {
                          debugPrint("WorkBodyWidget body update $text");
                          todoProvider.putItem(
                              widget.task.key, widget.task.title, text);
                        },
                        onTap: () {
                          print('Editing stated $widget');
                        },
                      )),
                  Container(height: 4, color: Colors.red),
                  Expanded(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(4),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      hintText: "任务正文2",
                    ),
                    controller: bodyController,
                    onChanged: (text) {
                      debugPrint("WorkBodyWidget body update 2 $text");
                      todoProvider.putItem(
                          widget.task.key, widget.task.title, text);
                    },
                    onTap: () {
                      print('Editing stated2 $widget');
                    },
                  ))
                ],
              ),
              onTapDown: (TapDownDetails details) {
                print('点击分割线');
                var diff = sourceHeight - details.localPosition.dy.abs();
                if (diff <= 5 && diff >= -5) {
                  setState(() {
                    dragCallback = (DragUpdateDetails details) {
                      print(
                          'onDragUpdate: ${details.delta.dy} ${details.localPosition.dy} '
                          '${details.globalPosition.dy}');
                      var newSourceHeight = sourceHeight + details.delta.dy;
                      print(
                          'onDragUpdate222: $sourceHeight ${newSourceHeight}');

                      if (newSourceHeight < 120 ||
                          newSourceHeight > 640 ||
                          details.localPosition.dy < 120 ||
                          details.localPosition.dy > 640) return;
                      setState(() {
                        sourceHeight = newSourceHeight;
                      });
                    };
                    dragEndCallback = (DragEndDetails details) {
                      print('点击分割线5');
                      setState(() {
                        dragCallback = null;
                        dragEndCallback = null;
                      });
                    };
                  });
                }
              },
              // onLongPressUp: () {
              //   print('点击分割线2');
              //   // setState(() {
              //   //   dragCallback = null;
              //   // });
              // },
              // onLongPressCancel: () {
              //   print('点击分割线3');
              // },
              // onLongPressEnd: (LongPressEndDetails details) {
              //   print('点击分割线4');
              // },
              // onVerticalDragStart: (DragStartDetails details) {
              //   var diff = sourceHeight - details.localPosition.dy.abs();
              //   if (diff <= 5 && diff >= -5) {
              //     setState(() {
              //       isDragging = true;
              //     });
              //   }
              // },
              onVerticalDragUpdate: dragCallback,
              // onVerticalDragUpdate: (DragUpdateDetails details) {
              //   print(
              //       'onDragUpdate: ${details.delta.dy} ${details
              //           .localPosition.dy} '
              //           '${details.globalPosition.dy}');
              //   var newSourceHeight = sourceHeight + details.delta.dy;
              //   print('onDragUpdate222: $sourceHeight ${newSourceHeight}');
              //
              //   if (newSourceHeight < 120 ||
              //       newSourceHeight > 640 ||
              //       details.localPosition.dy < 120 ||
              //       details.localPosition.dy > 640 ||
              //       !isDragging) return;
              //   setState(() {
              //     sourceHeight = newSourceHeight;
              //   });
              // },
              onVerticalDragEnd: dragEndCallback,
            ))
          ]),
          if (homeProvider.showDatePicker)
            Positioned(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromRGBO(229, 229, 229, 100),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: const MyDatePickerApp(),
              ),
              left: 0,
              top: 40,
            )
        ],
      ),
    );
  }
}
