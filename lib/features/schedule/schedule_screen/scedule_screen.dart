import 'package:algoriza_todo_app/core/util/widgets/my_appBar.dart';
import 'package:algoriza_todo_app/features/schedule/schedule_widget/schedule_widget.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Schedule',
        context: context,
      ),
      body: const ScheduleWidget(),
    );
  }
}
