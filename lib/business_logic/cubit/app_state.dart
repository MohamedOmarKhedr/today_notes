part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class AppOpenDataBaseState extends AppState {}

class AppLoadingDatabaseState extends AppState {}

class AppDoneDatabaseState extends AppState {}

class AppInsertNoteDoneState extends AppState {}

class CheckedOrNoDoneState extends AppState {}

class AppEditNoteDoneState extends AppState {}

class AppDeleteNoteDoneState extends AppState {}

class AppOpenDaysDataBaseState extends AppState {}

class AppLoadingDaysDatabaseState extends AppState {}

class AppDoneDaysDatabaseState extends AppState {}

class AppInsertDayDoneState extends AppState {}

class GoToTodayState extends AppState {}

class ShowDateSelectedState extends AppState {}

class GetNotesDatesSetState extends AppState {}

class GetNotesTheSameDateState extends AppState {}

class SortDatesSetState extends AppState {}
