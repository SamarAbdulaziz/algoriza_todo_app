import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UncompletedTasksSection extends StatelessWidget {
  const UncompletedTasksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            if (cubit.allTasks[index]['completed'] == 'false') {
              return TaskItem(
                taskItem: cubit.allTasks[index],
              );
            }
            else
              return Container();
          },
          itemCount: cubit.allTasks.length,
        );
      },
    );
  }
}
