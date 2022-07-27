import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.taskItem,
  }) : super(key: key);
  final Map taskItem;

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
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
            cubit.isCompleted = value!;
            cubit.updateCompletedDatabase(
                id: taskItem['id'], isCompleted: cubit.isCompleted);
            debugPrint('$value');
          },
          value:taskItem['completed']=='true'?true:false ,
          controlAffinity: ListTileControlAffinity.leading,
          secondary: PopupMenuButton(
              itemBuilder: (context) =>
              [
                    PopupMenuItem(
                      onTap: () {
                        cubit.isCompleted = true;
                        debugPrint('${cubit.isCompleted}');
                        cubit.updateCompletedDatabase(
                            id: taskItem['id'], isCompleted: cubit.isCompleted);
                      },
                      child: const Text('Completed'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        cubit.isCompleted = false;
                        debugPrint('${cubit.isCompleted}');
                        cubit.updateCompletedDatabase(
                            id: taskItem['id'], isCompleted: cubit.isCompleted);
                      },
                      child: const Text('Uncompleted'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        cubit.isFavorite = !cubit.isFavorite;
                        debugPrint('favorite: ${cubit.isFavorite}');
                        cubit.updateFavoriteDatabase(
                            id: taskItem['id'], isFavorite: cubit.isFavorite);
                        cubit.isFavorite
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Added to favorite',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: appColor,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.only(bottom: 100.0),
                                ),
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Removed from favorite',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(
                                    bottom: 100.0,
                                  ),
                                ),
                              );
                      },
                      child: const Text('Favorite'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        //todo delete item
                        cubit.deleteRowTodoAppDatabase(id: taskItem['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Task Deleted',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.only(bottom: 100.0),
                          ),
                        );
                      },
                      child: const Text('Delete'),
                    ),
                  ]),
        ),
      ),
    );
  }
}
