import 'package:algoriza_todo_app/core/util/widgets/my_button.dart';
import 'package:algoriza_todo_app/features/add_task/presentation/pages/add_task.dart';
import 'package:algoriza_todo_app/features/board/presentation/widgets/Completed_tasks.dart';
import 'package:algoriza_todo_app/features/board/presentation/widgets/all_tasks.dart';
import 'package:algoriza_todo_app/features/board/presentation/widgets/favorite_tasks.dart';
import 'package:algoriza_todo_app/features/board/presentation/widgets/uncompleted_tasks.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              AllTasksSection(),
              CompletedTasksSection(),
              UncompletedTasksSection(),
              FavoriteTasksSection(),
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

      ],
    );
  }
}
