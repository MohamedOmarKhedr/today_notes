import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:today_notes/business_logic/cubit/app_cubit.dart';
import 'package:today_notes/presentation/component/calendar_table.dart';
import 'package:today_notes/presentation/component/insert_note_alert.dart';
import 'package:today_notes/presentation/component/notes_list_builder.dart';
import 'package:today_notes/presentation/styles/colors.dart';
import 'package:today_notes/presentation/widgets/my_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map> nodesList;
  late Set<String> notesDatesSet;
  late String dateSelectedByUser;

  @override
  void didChangeDependencies() {
    print(DateTime.now());
    nodesList = AppCubit.get(context).notes;
    notesDatesSet = AppCubit.get(context).notesDatesSet;
    dateSelectedByUser = AppCubit.get(context).dateSelectedByUser;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffDC4D3F),
            title: const Text("Today Nodes"),
            actions: [
              TextButton(
                  onPressed: () {
                    AppCubit.get(context).goToToday();
                  },
                  child:
                      MyText(text: "Today", textColor: white, textSize: 14.sp))
            ],
          ),
          body: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                NotesCalenderTable(
                    selectedDate: AppCubit.get(context).selectedDay),
                Expanded(
                    child: NotesListBuilder(
                  notesDatesSet: notesDatesSet,
                  notesList: nodesList,
                ))
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const InsertNoteAlert();
                },
              );
            },
            backgroundColor: white,
            child: Icon(
              Icons.add,
              color: const Color(0xffDC4D3F),
              size: 25.sp,
            ),
          ),
        );
      },
    );
  }
}
