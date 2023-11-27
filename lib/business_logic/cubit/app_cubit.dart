import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  String dateSelectedByUser = "";

  DateTime selectedDay = DateTime.now();

  List<Map> notes = [];

  List<Map> days = [];
  List<Map> notesChecked = [];

  Set<String> notesDatesSet = {};

  late Database notesDatabase;

  void goToToday() {
    selectedDay = DateTime.now();
    emit(GoToTodayState());
  }

  Future<void> showDateSelectedByUser(DateTime dateSelected) async {
    if (dateSelected.day.toString().length == 1 &&
        dateSelected.month.toString().length == 1) {
      dateSelectedByUser =
          "0${dateSelected.day}/0${dateSelected.month}/${dateSelected.year}";
    } else if (dateSelected.day.toString().length == 1) {
      dateSelectedByUser =
          "0${dateSelected.day}/${dateSelected.month}/${dateSelected.year}";
    } else if (dateSelected.month.toString().length == 1) {
      dateSelectedByUser =
          "${dateSelected.day}/0${dateSelected.month}/${dateSelected.year}";
    } else {
      dateSelectedByUser =
          "${dateSelected.day}/${dateSelected.month}/${dateSelected.year}";
    }

    emit(ShowDateSelectedState());
  }

  Future<void> getNotesDatesSet(List<Map> notesList) async {
    for (Map note in notesList) {
      notesDatesSet.add(note['date']);
    }
    if (kDebugMode) {
      print(notesList);
    }
    if (kDebugMode) {
      print(notesDatesSet);
      print(notesDatesSet.length);
    }
    emit(GetNotesDatesSetState());
  }

  List<Map> getNotesTheSameDate(int index) {
    List<Map> notesTheSameDate = [];
    for (Map note in notes) {
      if (note['date'] == notesDatesSet.elementAt(index)) {
        notesTheSameDate.add(note);
      }
    }
    return notesTheSameDate;
  }

  void sortDatesSet(Set<String> notesDatesSet) {
    List<String> notesDateslist = notesDatesSet.toList();
    notesDateslist.sort(
      (a, b) {
        if (a.substring(6, 8) != b.substring(6, 8)) {
          return int.parse(a.substring(6, 8))
              .compareTo(int.parse(b.substring(6, 8)));
        } else if (a.substring(3, 4) != b.substring(3, 4)) {
          return int.parse(a.substring(3, 4))
              .compareTo(int.parse(b.substring(3, 4)));
        } else {
          return int.parse(a.substring(0, 1))
              .compareTo(int.parse(b.substring(0, 1)));
        }
      },
    );
    notesDatesSet = notesDateslist.toSet();
    emit(SortDatesSetState());
  }

//----------------------------------------

  void createDatabase() {
    openDatabase(
      "notes.db",
      version: 1,
      onCreate: (db, version) {
        if (kDebugMode) {
          print("Notes Database created");
        }

        db
            .execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, discription TEXT, date TEXT,isChecked TEXT, type TEXT)')
            .then((value) {
          if (kDebugMode) {
            print("Notes Table created");
          }
        }).catchError((error) {
          if (kDebugMode) {
            print("error while Notes Table created: $error");
          }
        });
      },
      onOpen: (db) {
        // TODO: get notes

        if (kDebugMode) {
          print("Notes Database opened");
        }
      },
    ).then((value) async {
      notesDatabase = value;
      getNotes(notesDatabase);
      emit(AppOpenDataBaseState());
    });
  }

  void getNotes(Database notesDatabase) async {
    emit(AppLoadingDatabaseState());

    notes.clear();

    await notesDatabase.rawQuery("SELECT * FROM notes").then((value) {
      for (Map<String, Object?> element in value) {
        notes.add(element);

        if (element['isChecked'] == 'true') {
          notesChecked.add(element);
        }
      }
    });
    emit(AppDoneDatabaseState());
    getNotesDatesSet(notes);
    sortDatesSet(notesDatesSet);
  }

  Future<void> insertNote(
      {required String date,
      required String title,
      required String discription,
      required String type}) async {
    await notesDatabase.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO notes(title, discription, date, type, isChecked) VALUES ("$title","$discription","$date","$type","false")');
    }).then((value) {
      if (kDebugMode) {
        print("note $value successfully insert!");
        emit(AppInsertNoteDoneState());
        getNotes(notesDatabase);
        getNotesDatesSet(notes);
        sortDatesSet(notesDatesSet);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("error while note inserted: $error");
      }
    });
  }

  Future<void> checkedOrNo({required String isChecked, required int id}) async {
    await notesDatabase.rawUpdate('UPDATE notes SET isChecked = ? WHERE id = ?',
        [isChecked, id]).then((value) {
      getNotes(notesDatabase);
      emit(CheckedOrNoDoneState());
    });
  }

  Future<void> editNote(
      {required String title,
      required String discription,
      required String date,
      required String type,
      required int id}) async {
    await notesDatabase.rawUpdate(
        'UPDATE notes SET title = ?, discription = ?, date = ?, type = ? WHERE id = ?',
        [title, discription, date, type, id]).then((value) {
      getNotes(notesDatabase);
      emit(AppEditNoteDoneState());
    });
  }

  Future<void> deleteNote({required int id}) async {
    await notesDatabase
        .rawDelete('DELETE FROM notes WHERE id = ?', [id]).then((value) {
      getNotes(notesDatabase);
      getNotesDatesSet(notes);
      emit(AppDeleteNoteDoneState());
    });
  }
}
