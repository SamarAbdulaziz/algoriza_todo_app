import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AllTasksSection extends StatelessWidget {
  const AllTasksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);

    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskItem(
              taskItem: cubit.allTasks[index],
            );
          },
          itemCount: cubit.allTasks.length,
        );
      },
    );
  }
}
