import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:algoriza_todo_app/features/board/presentation/widgets/board_widget.dart';
import 'package:algoriza_todo_app/features/schedule/schedule_screen/scedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Board',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Calender',
                    style: TextStyle(
                      color:appColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0.0,
              shape: const Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 2.0,
                ),
              ),
            ),
            body: BoardWidget(),
          ),
        );
      },
    );
  }
}
// IconButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ScheduleScreen(),
// ),
// );
// cubit.getTodoAppDatabase();
// },
// icon: Icon(
// Icons.calendar_today_outlined,
// color: appColor,
// ),
// ),