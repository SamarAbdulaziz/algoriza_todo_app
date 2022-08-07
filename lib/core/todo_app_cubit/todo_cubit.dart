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
  TextEditingController repeatController = TextEditingController();
  int taskColor = 0;

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
              '"false",'
              '"false")')
          .then((value) {
        debugPrint('Data inserted');
        emit(DataInsertedState());
        titleController.clear();
        dateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        remindController.clear();
        repeatController.clear();
      }).catchError((error) {
        debugPrint(error.toString());
      });
    });
  }

  List<Map> allTasks = [];
  void getTodoAppDatabase() async {
    emit(GetDatabaseLoadingState());
    await database.rawQuery('SELECT * FROM $tableName').then((value) {
      allTasks = value;
      debugPrint('$allTasks');
      emit(GetDataState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void updateCompletedDatabase({
    bool? isCompleted,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE $tableName SET completed = ? WHERE id = ?', [
      '${isCompleted.toString()}',
      '$id',
    ]).then((value) {
      getTodoAppDatabase();
      emit(DataUpdatedCompleteFieldState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

void updateFavoriteDatabase({
    bool? isFavorite,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE $tableName SET favorite = ? WHERE id = ?', [
      '${isFavorite.toString()}',
      '$id',
    ]).then((value) {
      getTodoAppDatabase();
      emit(DataUpdatedFavoriteFieldState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void deleteRowTodoAppDatabase({required int id}) {
    database.rawDelete('DELETE FROM $tableName WHERE id = ?', ['$id']).then(
        (value) {
      debugPrint('Row deleted');
      emit(RowDeletedState());
      getTodoAppDatabase();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  String selectedDay = DateFormat('EEEEE').format(DateTime.now());
  String selectedDate = DateFormat.yMMMd().format(DateTime.now());
  String convertedSelectedDate = DateFormat.yMd().format(DateTime.now());

  void formatTheDate(DateTime date) {
    selectedDay = DateFormat('EEEEE').format(date);
    selectedDate = DateFormat.yMMMd().format(date); //jul 24,2022
    convertedSelectedDate = DateFormat.yMd().format(date);
    emit(DayChangedState());
  }

  bool checkDateToShowTasksOfThatDate(int index) {
    var theDateOfTheTask = allTasks[index]['date'];
    if (theDateOfTheTask == convertedSelectedDate) {
      emit(CheckDateToShowTasksOfThatDateState());
      return true;
    } else {
      emit(CheckDateToShowTasksOfThatDateState());
      return false;
    }
  }

  List<String> remindList = [
    '1 day before',
    '1 hour before',
    '30 minutes before',
    '10 minutes before',
    'On Time',
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

  void changeColorIndex(int value){
    taskColor=value;
    emit(ChangeColorInAddTaskState());
  }
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
  }

  var notification;

  void initNotifications() {
    notification = Notifications();
    notification.initializeNotification();
    notification.requestIOSPermissions();
  }
}