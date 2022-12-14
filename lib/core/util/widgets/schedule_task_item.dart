// import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
// import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
// import 'package:flutter/material.dart';
//
// class ScheduleTaskItem extends StatelessWidget {
//   const ScheduleTaskItem({
//     Key? key,
//     required this.taskItem,
//   }) : super(key: key);
//   final Map taskItem;
//
//   @override
//   Widget build(BuildContext context) {
//     var cubit = TodoCubit.get(context);
//
//     return Theme(
//       data: Theme.of(context).copyWith(
//         checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0)),
//           side: MaterialStateBorderSide.resolveWith(
//                 (states) => const BorderSide(
//                     width: 1.0,
//                     color: Colors.white,
//                 ),
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.circular(20),
//               color: taskColorsList[taskItem['color']],
//           ),
//           child: CheckboxListTile(
//             title: Text(
//               taskItem['startTime'],
//               style: const TextStyle(
//                 color: Colors.white
//               ),
//             ),
//             activeColor: taskColorsList[ taskItem['color']],
//             subtitle: Text(
//               taskItem['title'],
//               style: const TextStyle(
//                   color: Colors.white),
//             ),
//             onChanged: (value) {
//               taskItem['completed'] = value!.toString();
//               cubit.updateCompletedDatabase(
//                   id: taskItem['id'], isCompleted:taskItem['completed']);
//               debugPrint('$value');
//             },
//             value: taskItem['completed'] == 'true' ? true : false,
//             controlAffinity: ListTileControlAffinity.trailing,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ScheduleTaskItem extends StatelessWidget {
  const ScheduleTaskItem({
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
              borderRadius: BorderRadius.circular(10.0)),
          side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: taskColorsList[taskItem['color']],
          ),
          child: CheckboxListTile(
            title: Text(
              taskItem['startTime'],
              style: const TextStyle(
                  color: Colors.white
              ),
            ),
            activeColor: taskColorsList[ taskItem['color']],
            subtitle: Text(
              taskItem['title'],
              style: const TextStyle(
                  color: Colors.white),
            ),
            onChanged: (value) {
              cubit.isCompleted = value!;
              cubit.updateCompletedDatabase(
                  id: taskItem['id'], isCompleted: cubit.isCompleted);
              debugPrint('$value');
            },
            value: taskItem['completed'] == 'true' ? true : false,
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ),
      ),
    );
  }
}
