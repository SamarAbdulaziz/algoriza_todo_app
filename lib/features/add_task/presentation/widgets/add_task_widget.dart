import 'package:algoriza_todo_app/core/todo_app_cubit/todo_cubit.dart';
import 'package:algoriza_todo_app/core/util/app_colors/app_colors.dart';
import 'package:algoriza_todo_app/core/util/widgets/mt_text_form_feild.dart';
import 'package:algoriza_todo_app/core/util/widgets/my_button.dart';
import 'package:algoriza_todo_app/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskWidget extends StatefulWidget {
  AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final formKey = GlobalKey<FormState>();

  int val = 0;
  // var notification;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   notification = Notifications();
  //   notification.initializeNotification();
  //   notification.requestIOSPermissions();
  // }

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    // DateTime start = DateTime.parse(cubit.startTimeController.text);
    // DateTime end = DateTime.parse(cubit.endTimeController.text);

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
                    //yMd..ymm
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Start time must not empty';
                            }
                          },
                          hintText: '11:00 AM',
                          suffixIcon: const Icon(Icons.access_time_outlined),
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.startTimeController.text =
                                  value!.format(context);
                            });
                          },
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'End Time must not empty';
                            }
                            // else if (start.isAfter(end)) {
                            //   return 'End Time must be after start time';
                            // }
                          },
                          hintText: '4:00 PM',
                          suffixIcon: const Icon(Icons.access_time_outlined),
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              cubit.endTimeController.text =
                                  value!.format(context);
                            });
                          },
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
                hintText: '5 minutes early',
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
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        //  cubit.changeColorInAddTaskScreen(val);
                      });
                      cubit.saveTaskColor(0);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[0],
                    ),
                  ),
                  Radio(
                    value: 1,
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        //  cubit.changeColorInAddTaskScreen(val);
                      });
                      cubit.saveTaskColor(1);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[1],
                    ),
                  ),
                  Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        //cubit.changeColorInAddTaskScreen(val);
                      });
                      cubit.saveTaskColor(2);
                    },
                    fillColor: MaterialStateProperty.all(
                      taskColorsList[2],
                    ),
                  ),
                  Radio(
                    value: 3,
                    groupValue: val,
                    onChanged: (int? value) {
                      setState(() {
                        val = value!;
                        //  cubit.changeColorInAddTaskScreen(val);
                      });
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
                  //   title:"Hello Notification",
                  //   subtitle:"Welcome to Flutter",
                  // );
                  // notification.scheduledNotification();

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}