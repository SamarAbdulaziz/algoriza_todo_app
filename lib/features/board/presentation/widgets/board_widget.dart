import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/widgets/my_button.dart';
import 'package:algoriza_todo_app/core/util/widgets/task_item.dart';
import 'package:algoriza_todo_app/features/add_task/presentation/pages/add_task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    return Column(
      children: [
        const TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              child: Text(
                'All',
              ),
            ),
            Tab(
              child: Text(
                'Completed',
              ),
            ),
            Tab(
              child: Text(
                'Uncompleted',
              ),
            ),
            Tab(
              child: Text(
                'Favorite',
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black12,
          thickness: 2.0,
        ),
        Expanded(
          child: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  DateTime date =
                      DateFormat.jm().parse(cubit.allTasks[index]['startTime']);
                  var myTime = DateFormat("HH:mm").format(date);
                  cubit.notification.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    cubit.allTasks[index],
                  );
                  return TaskItem(
                    taskItem:cubit.allTasks[index],
                  );
                },
                itemCount:cubit.allTasks.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) => TaskItem(
                  taskItem:cubit.completedTasks[index],
                ),
                itemCount:cubit.completedTasks.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) => TaskItem(
                  taskItem:cubit.unCompletedTasks[index],
                ),
                itemCount:cubit.unCompletedTasks.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) => TaskItem(
                  taskItem:cubit.favoriteTasks[index],
                ),
                itemCount:cubit.favoriteTasks.length,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MyButton(
            text: 'Add a task',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTask(),
                ),
              );
            },
          ),
        ),
        // MyButton(
        //   text: 'Delete Table',
        //   onPressed: () {
        //   cubit.deleteTableTodoAppDatabase();
        //   },
        // ),
      ],
    );
  }
}
