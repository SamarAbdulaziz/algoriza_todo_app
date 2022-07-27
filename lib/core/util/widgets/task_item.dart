import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.taskItem,
  }) : super(key: key);
  final Map taskItem;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                  width: 1.0,
                  color: taskColorsList[taskItem['color']],
                ),
              ),
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CheckboxListTile(
          title: Text(
            taskItem['title'],
          ),
          activeColor: taskColorsList[taskItem['color']],
          onChanged: (value) {
            TodoCubit.get(context).isCompleted = value!;
            TodoCubit.get(context).updateCompletedDatabase(
                id: taskItem['id'],
                isCompleted: TodoCubit.get(context).isCompleted);
            debugPrint('$value');
          },
          value:taskItem['completed']=='true'?true:false ,
          controlAffinity: ListTileControlAffinity.leading,
          secondary: PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        TodoCubit.get(context).isCompleted = true;
                        debugPrint('${TodoCubit.get(context).isCompleted}');
                        TodoCubit.get(context).updateCompletedDatabase(
                            id: taskItem['id'],
                            isCompleted: TodoCubit.get(context).isCompleted);
                      },
                      child: Text('Completed'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        TodoCubit.get(context).isCompleted = false;
                        debugPrint('${TodoCubit.get(context).isCompleted}');
                        TodoCubit.get(context).updateCompletedDatabase(
                            id: taskItem['id'],
                            isCompleted: TodoCubit.get(context).isCompleted);
                      },
                      child: Text('Uncompleted'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        TodoCubit.get(context).isFavorite =
                            !TodoCubit.get(context).isFavorite;
                        debugPrint(
                            'favorite: ${TodoCubit.get(context).isFavorite}');
                        TodoCubit.get(context).updateFavoriteDatabase(
                            id: taskItem['id'],
                            isFavorite: TodoCubit.get(context).isFavorite);
                      },
                      child: Text('Favorite'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        //todo delete item
                        TodoCubit.get(context)
                            .deleteRowTodoAppDatabase(id: taskItem['id']);
                      },
                      child: Text('Delete'),
                    ),
                  ]),
        ),
      ),
    );
  }
}
