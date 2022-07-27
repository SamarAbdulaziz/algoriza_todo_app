part of 'todo_cubit.dart';

@immutable
abstract class TodoStates {}

class TodoInitialState extends TodoStates {}

class TableCreatedState extends TodoStates {}

class DatabaseOpenedState extends TodoStates {}

class DataInsertedState extends TodoStates {}

class GetDatabaseLoadingState extends TodoStates {}

class GetDataState extends TodoStates {}

class DataUpdatedCompleteFieldState extends TodoStates {}

class DataUpdatedFavoriteFieldState extends TodoStates {}

class RowDeletedState extends TodoStates {}

class DeleteDataState extends TodoStates {}

class BoxCheckedState extends TodoStates {}

class DayChangedState extends TodoStates {}

class CheckDateToShowTasksOfThatDateState extends TodoStates {}

class ReminderState extends TodoStates {}

class RepeatState extends TodoStates {}

class ChangeColorInAddTaskState extends TodoStates {}
