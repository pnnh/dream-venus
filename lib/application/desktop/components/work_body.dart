import 'package:dream/application/desktop/provider/home.dart';
import 'package:dream/application/desktop/provider/todo.dart';
import 'package:dream/services/models/task.dart';
import 'package:dream/widgets/datepicker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:split_view/split_view.dart';

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
                child: SplitView(
              viewMode: SplitViewMode.Vertical,
              indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
              gripSize: 8,
              gripColor: Color(0XFFEEEEEE),
              gripColorActive: Color(0XFFEEEEEE),
              activeIndicator: const SplitIndicator(
                viewMode: SplitViewMode.Vertical,
                isActive: true,
              ),
              controller: SplitViewController(
                  limits: [WeightLimit(min: 0.1), WeightLimit(min: 0.1)]),
              onWeightChanged: (w) => print("Vertical $w"),
              children: [
                Container(
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
                  ),
                  color: Colors.white,
                ),
                Container(
                  color: Colors.white,
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
                      debugPrint('Editing stated2 $widget');
                    },
                  ),
                ),
              ],
            ))
          ]),
          if (homeProvider.showDatePicker)
            Positioned(
              left: 0,
              top: 40,
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
            )
        ],
      ),
    );
  }
}
