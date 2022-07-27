import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CompletedTasksSection extends StatelessWidget {
  const CompletedTasksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);

    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            DateTime date =
            DateFormat.jm().parse(cubit.allTasks[index]['startTime']);
            var myTime = DateFormat("HH:mm").format(date);
            cubit.notification.scheduledNotification(
              int.parse(myTime.toString().split(":")[0]),
              int.parse(myTime.toString().split(":")[1]),
              cubit.allTasks[index],
            );
            if (cubit.allTasks[index]['completed'] == 'true') {
              return TaskItem(
                taskItem: cubit.allTasks[index],
              );
            } else {
              return Container();
            }
          },
          itemCount: cubit.allTasks.length,
        );
      },
    );
  }
}
