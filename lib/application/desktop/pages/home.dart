import 'package:dream/application/desktop/provider/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/filter_group.dart';
import '../components/title_bar.dart';
import '../components/todo_list.dart';
import '../components/work_group.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            const TitleBarWidget(),
            Expanded(
                child: GestureDetector(
                    onTapDown: (detail) {
                      debugPrint("out click");
                      homeProvider.closeDatePicker();
                    },
                    child: Row(children: [
                      Container(
                          width: 56,
                          padding: const EdgeInsets.only(top: 8),
                          color: const Color.fromRGBO(242, 246, 255, 100),
                          child: const WorkGroupWidget()),
                      if (homeProvider.showFilter)
                        Container(
                            width: 240,
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                              color: Color.fromRGBO(229, 229, 229, 100),
                              width: 1,
                            ))),
                            child: const FilterGroupWidget()),
                      const TodoListWidget(),
                    ])))
          ],
        ));
  }
}
