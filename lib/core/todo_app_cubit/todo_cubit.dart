import 'package:algoriza_todo_app/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of<TodoCubit>(context);
  late Database database;
  String tableName = 'tasks';

  void createTodoAppDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) {
        debugPrint('Database created'); //todo add color
        db
            .execute('CREATE TABLE $tableName ('
                'id INTEGER PRIMARY KEY,'
                'title TEXT ,'
                'date TEXT,'
                'startTime TEXT,'
                'endTime TEXT,'
                'remind TEXT,'
                'repeat TEXT,'
                'color INTEGER,'
                'completed TEXT,'
                'favorite TEXT)')
            .then((value) {
          emit(TableCreatedState());
          debugPrint('Table created');
        }).catchError((error) {
          debugPrint(error.toString());
        });
      },
      onOpen: (Database db) {
        emit(DatabaseOpenedState());
        debugPrint('Database opened');
        database = db;
        getTodoAppDatabase();
      },
    );
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  int taskColor = 0; //=taskColors[0].toString();
  TextEditingController repeatController = TextEditingController();
  bool isCompleted = false;
  bool isFavorite = false;

  void insertTodoAppDatabase() {
    database.transaction((txn) async {
      await txn
          .rawInsert('INSERT INTO $tableName ('
              'title,'
              'date,'
              'startTime,'
              'endTime,'
              'remind,'
              'repeat,'
              'color,'
              'completed,'
              'favorite) '
              'VALUES ('
              '"${titleController.text}",'
              '"${dateController.text}",'
              '"${startTimeController.text}",'
              '"${endTimeController.text}",'
              '"${remindController.text}",'
              '"${repeatController.text}",'
              '"${taskColor}",'
              '"${isCompleted.toString()}",'
              '"${isFavorite.toString()}")')
          .then((value) {
        debugPrint('Data inserted');
        emit(DataInsertedState());
        titleController.text='';
        dateController.text='';
        startTimeController.text='';
        endTimeController.text='';
        remindController.text='';
        repeatController.text='';
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });
  }

  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> favoriteTasks = [];

  void getTodoAppDatabase() async {
    completedTasks = [];
    unCompletedTasks = [];
    favoriteTasks = [];
    emit(GetDatabaseLoadingState());
    await database.rawQuery('SELECT * FROM $tableName').then((value) {
      allTasks = value;
      debugPrint('$allTasks');
      allTasks.forEach((element) {
        if (element['completed'] == 'true') {
          //debugPrint('${element['completed']}');
          completedTasks.add(element);
        } else {
          unCompletedTasks.add(element);
        }
        if (element['favorite'] == 'true') {
          favoriteTasks.add(element);
        }
      });
      emit(GetDataState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void updateDatabase({
    bool? isCompleted,
    bool? isFavorite,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE $tableName SET completed = ? , favorite = ? WHERE id = ?', [
      '${isCompleted.toString()}',
      '${isFavorite.toString()}',
      '$id',
    ]).then((value) {
      getTodoAppDatabase();
      emit(DataUpdatedState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void deleteRowTodoAppDatabase({required int id}) {
    completedTasks = [];
    unCompletedTasks = [];
    favoriteTasks = [];
    database.rawDelete('DELETE FROM $tableName WHERE id = ?', ['$id']).then(
        (value) {
      debugPrint('Row deleted');
      emit(RowDeletedState());
      getTodoAppDatabase();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void deleteTableTodoAppDatabase() async {
    await database.delete('$tableName').then((value) {
      debugPrint('table deleted');
      emit(DeleteDataState());
      getTodoAppDatabase();
    });
  }

  // bool boxChecked = false;
  //
  // void isBoxChecked(bool? value) {
  //   boxChecked = value!;
  //   emit(BoxCheckedState());
  // }
  String selectedDay = DateFormat('EEEEE').format(DateTime.now());
  String selectedDate = DateFormat.yMMMd().format(DateTime.now());
  String convertedSelectedDate = DateFormat.yMd().format(DateTime.now());

  void formatTheDate(DateTime date) {
    selectedDay = DateFormat('EEEEE').format(date);
    selectedDate = DateFormat.yMMMd().format(date); //jul 24,2022
    convertedSelectedDate = DateFormat.yMd().format(date);
    debugPrint('$selectedDay');
    debugPrint('$selectedDate');
    debugPrint('$convertedSelectedDate');

    emit(DayChangedState());
  }

  bool checkDateToShowTasksOfThatDate(int index) {
    // changeTheDay();
    var theDateOfTheTask = allTasks[index]['date'];
    if (theDateOfTheTask == convertedSelectedDate) {
      emit(CheckDateToShowTasksOfThatDateState());
      return true;
    } else {
      // debugPrint('the date of the task ==== $theDateOfTheTask');
      // debugPrint('the converted selected date ==== $convertedSelectedDate');
      emit(CheckDateToShowTasksOfThatDateState());
      return false;
    }
  }

  List<String> remindList = [
    '5 minutes early',
    '10 minutes early',
    '15 minutes early',
    '20 minutes early',
  ];

  void setReminder(String value) {
    remindController.text = value;
    emit(ReminderState());
  }

  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  void setRepeat(String value) {
    repeatController.text = value;
    emit(RepeatState());
  }

//it didnt work so i used Statefullwidget
//   int val = 0;
//
//   void changeColorInAddTaskScreen(int? value) {
//     val = value!;
//     emit(ChangeColorInAddTaskScreen());
//     print(val.toString());
//   }

  void saveTaskColor(int val) {
    switch(val){
      case 0:
        taskColor=0;
        break;
        case 1:
          taskColor=1;
          break;
        case 2:
          taskColor=2;
          break;
          case 3:
          taskColor=3;
          break;
      default:
        taskColor=4;
    }
    // taskColor = taskColorsList[val].toString();
    // print('the color $taskColorsList[$val]');
  }

  var notification;

  void initNotifications() {
    notification = Notifications();
    notification.initializeNotification();
    notification.requestIOSPermissions();
  }
}