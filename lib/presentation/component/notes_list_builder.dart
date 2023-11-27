import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:today_notes/business_logic/cubit/app_cubit.dart';
import 'package:today_notes/presentation/component/notes_list_item.dart';
import 'package:today_notes/presentation/widgets/my_text.dart';

// ignore: must_be_immutable
class NotesListBuilder extends StatefulWidget {
  List<Map> notesList;
  Set<String> notesDatesSet;
  NotesListBuilder(
      {super.key, required this.notesList, required this.notesDatesSet});

  @override
  State<NotesListBuilder> createState() => _NotesListBuilderState();
}

class _NotesListBuilderState extends State<NotesListBuilder> {
  String nowDate =
      "${DateTime.now().day}/0${DateTime.now().month}/${DateTime.now().year}";
  final tomorrow = DateTime.now().add(const Duration(days: 1));
  late String tomorrowDate;
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  late String yesterdayDate;
  @override
  void didChangeDependencies() {
    tomorrowDate = "${tomorrow.day}/0${tomorrow.month}/${tomorrow.year}";
    yesterdayDate = "${yesterday.day}/0${yesterday.month}/${yesterday.year}";
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, i) {
          List<Map> notesTheSameDate =
              AppCubit.get(context).getNotesTheSameDate(i);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.notesDatesSet.elementAt(i) == nowDate)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: MyText(
                    text: "Today: ${widget.notesDatesSet.elementAt(i)}",
                    textSize: 14.sp,
                    weight: FontWeight.bold,
                    textColor: const Color(0xFF903D1C),
                  ),
                )
              else if (widget.notesDatesSet.elementAt(i) == yesterdayDate)
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: MyText(
                      text: "Yesterday: ${widget.notesDatesSet.elementAt(i)}",
                      textSize: 14.sp,
                      weight: FontWeight.bold,
                      textColor: const Color(0xFF903D1C),
                    ))
              else if (widget.notesDatesSet.elementAt(i) == tomorrowDate)
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: MyText(
                      text: "Tomorrow: ${widget.notesDatesSet.elementAt(i)}",
                      textSize: 14.sp,
                      weight: FontWeight.bold,
                      textColor: const Color(0xFF903D1C),
                    ))
              else
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: MyText(
                      text: widget.notesDatesSet.elementAt(i),
                      textSize: 14.sp,
                      weight: FontWeight.bold,
                      textColor: const Color(0xFF903D1C),
                    )),
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: NotesListItem(
                  notesTheSameDate: notesTheSameDate,
                  notesDatesSet: widget.notesDatesSet,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, i) => const SizedBox(),
        itemCount: widget.notesDatesSet.length);
  }
}
