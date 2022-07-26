import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/features/board/presentation/pages/board_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit()..createTodoAppDatabase()..initNotifications(),
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeData(
            //     appBarTheme: AppBarTheme(
            //         systemOverlayStyle: SystemUiOverlayStyle(
            //           statusBarColor: Colors.white,
            //         ),
            //     ),
            //
            // ),
            home: BoardScreen(),
          );
        },
      ),
    );
  }


}
