import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:algoriza_todo_app/core/util/widgets/schedule_task_item.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: appColor,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            cubit.formatTheDate(date);
          },
          dateTextStyle: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        const Divider(
          color: Colors.black12,
          thickness: 2.0,
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                cubit.selectedDay,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const Spacer(),
              Text(
                cubit.selectedDate,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {

              DateTime date =
              DateFormat.jm().parse(cubit.allTasks[index]['startTime']);
              var myTime = DateFormat("HH:mm").format(date);
              cubit.notification.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                cubit.allTasks[index],
              );



              if (cubit.allTasks[index]['repeat'] == 'Daily') {
                return ScheduleTaskItem(
                  taskItem: cubit.allTasks[index],
                );
              }
              if (cubit.allTasks[index]['date'] ==
                  cubit.convertedSelectedDate) {
                return ScheduleTaskItem(
                  taskItem: cubit.allTasks[index],
                );
              } else {
                return Container();
              }
            },
            itemCount: cubit.allTasks.length,
          ),
        ),
      ],
    );
  }
}
