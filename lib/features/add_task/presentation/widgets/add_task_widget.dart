import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:algoriza_todo_app/core/util/widgets/mt_text_form_feild.dart';
import 'package:algoriza_todo_app/core/util/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskWidget extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  var notification;

  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextFormField(
                controller: cubit.titleController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Title must not empty';
                  }
                },
                onTap: () {},
                hintText: 'Task title',
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextFormField(
                controller: cubit.dateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date must not empty';
                  }
                },
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 5),
                  ).then((value) {
                    cubit.dateController.text = DateFormat.yMd().format(value!);
                  });
                },
                hintText: 'Task Date',
                type: TextInputType.datetime,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Start Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MyTextFormField(
                          controller: cubit.startTimeController,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.startTimeController.text =
                                  value!.format(context);
                              startTime = DateFormat("hh:mm a")
                                  .parse(cubit.startTimeController.text);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Start time must not empty';
                            }
                          },
                          hintText: '12:00 AM',
                          suffixIcon: const Icon(Icons.access_time_outlined),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'End Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        MyTextFormField(
                          controller: cubit.endTimeController,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.endTimeController.text =
                                  value!.format(context);
                              endTime = DateFormat("hh:mm a")
                                  .parse(cubit.endTimeController.text);
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'End Time must not empty';
                            }
                            // if (endTime.hour <= startTime.hour&&endTime.minute==startTime.minute)
                            // {
                            //   return 'End time must be after start time';
                            // }
                            // if(startTime.hour==endTime.hour){
                            //   if(startTime.minute==endTime.minute){
                            //     return 'Minutes must be different';
                            //   }
                            //   // else if(startTime.minute>=endTime.minute){
                            //   //   return 'Times must be different';
                            //   // }
                            //
                            // }
                            // if(startTime.hour>=endTime.hour){
                            //   return 'End time must be after start time';
                            // }
                          },
                          hintText: '12:00 PM',
                          suffixIcon: const Icon(Icons.access_time_outlined),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Remind',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextFormField(
                //Todo
                controller: cubit.remindController,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Remind must not empty';
                  }
                },
                onTap: () {},
                hintText: '1 day before',
                suffixIcon: DropdownButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  underline: Container(),
                  items: cubit.remindList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    cubit.setReminder(value!);
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Repeat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextFormField(
                //Todo
                controller: cubit.repeatController,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'field must not empty';
                  }
                },
                onTap: () {},
                hintText: 'Daily',
                suffixIcon: DropdownButton(
                  elevation: 0,
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: cubit.repeatList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    cubit.setRepeat(value!);
                  },
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Choose Color',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Radio(
                    value: 0,
                    groupValue: cubit.taskColor,
                    onChanged: (int? value) {
                      cubit.changeColorIndex(value!);
                      cubit.saveTaskColor(0);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[0],
                    ),
                  ),
                  Radio(
                    value: 1,
                    groupValue: cubit.taskColor,
                    onChanged: (int? value) {
                      cubit.changeColorIndex(value!);
                      cubit.saveTaskColor(1);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[1],
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: cubit.taskColor,
                    onChanged: (int? value) {
                      cubit.changeColorIndex(value!);
                      cubit.saveTaskColor(2);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[2],
                    ),
                  ),
                  Radio(
                    value: 3,
                    groupValue: cubit.taskColor,
                    onChanged: (int? value) {
                      cubit.changeColorIndex(value!);
                      cubit.saveTaskColor(3);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[3],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyButton(
                text: 'Create a task',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.insertTodoAppDatabase();
                    Navigator.pop(context);
                    cubit.getTodoAppDatabase();
                  }
                  // cubit.notification.displayNotification(
                  //   title: cubit.titleController.text,
                  //   subtitle: 'At${cubit.dateController.text}',
                  // );
                 // cubit.notification.scheduledNotification();

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
