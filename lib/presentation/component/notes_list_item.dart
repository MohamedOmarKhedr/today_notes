// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import 'package:today_notes/business_logic/cubit/app_cubit.dart';
import 'package:today_notes/presentation/styles/colors.dart';
import 'package:today_notes/presentation/widgets/my_text.dart';

// ignore: must_be_immutable
class NotesListItem extends StatelessWidget {
  final List<Map> notesTheSameDate;
  Set notesDatesSet;
  NotesListItem({
    Key? key,
    required this.notesTheSameDate,
    required this.notesDatesSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notesTheSameDate.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 1.h,
        );
      },
      itemBuilder: (context, index) {
        Map indexNote = notesTheSameDate[index];

        return indexNote['isChecked'] == 'false'
            ? Dismissible(
                key: Key(indexNote['id'].toString()),
                onDismissed: (direction) async {
                  await AppCubit.get(context).deleteNote(id: indexNote['id']);

                  Fluttertoast.showToast(
                      msg: "note delete successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: darkBlue,
                      fontSize: 14.sp);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.sp, color: const Color(0xffDC4D3F)),
                      borderRadius: BorderRadius.circular(5.sp)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.circle_outlined,
                            color: Color(0xffDC4D3F),
                          ),
                          onPressed: () {
                            AppCubit.get(context).checkedOrNo(
                                isChecked: "true", id: indexNote['id']);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                              text: "${indexNote['title']}",
                              textSize: 14.sp,
                              weight: FontWeight.bold,
                              textColor: const Color(0xffDC4D3F),
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            MyText(
                              maxLines: 3,
                              text: "${indexNote['discription']}",
                              textSize: 10.sp,
                              textColor: const Color(0xffDC4D3F),
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (indexNote['type'] == 'personal')
                              Icon(
                                Icons.person,
                                size: 10.sp,
                                color: const Color(0xffDC4D3F),
                              )
                            else if (indexNote['type'] == 'work')
                              Icon(
                                Icons.work,
                                size: 10.sp,
                                color: const Color(0xffDC4D3F),
                              )
                            else
                              Icon(
                                Icons.circle,
                                size: 10.sp,
                                color: const Color(0xffDC4D3F),
                              ),
                            SizedBox(
                              width: 1.w,
                            ),
                            MyText(
                              text: "${indexNote['type']}",
                              textSize: 10.sp,
                              textColor: const Color(0xffDC4D3F),
                              textOverflow: TextOverflow.ellipsis,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Dismissible(
                key: Key(indexNote['id'].toString()),
                onDismissed: (direction) async {
                  await AppCubit.get(context).deleteNote(id: indexNote['id']);

                  Fluttertoast.showToast(
                      msg: "contact delete successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: darkBlue,
                      fontSize: 14.sp);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.sp,
                        color: Colors.greenAccent,
                      ),
                      borderRadius: BorderRadius.circular(5.sp)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () {
                            AppCubit.get(context).checkedOrNo(
                                isChecked: "false", id: indexNote['id']);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText(
                              text: "${indexNote['title']}",
                              textSize: 14.sp,
                              weight: FontWeight.bold,
                              textColor: Colors.greenAccent,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            MyText(
                              text: "${indexNote['discription']}",
                              textSize: 10.sp,
                              textColor: Colors.greenAccent,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (indexNote['type'] == 'personal')
                              Icon(
                                Icons.person,
                                size: 10.sp,
                                color: Colors.greenAccent,
                              )
                            else if (indexNote['type'] == 'work')
                              Icon(
                                Icons.work,
                                size: 10.sp,
                                color: Colors.greenAccent,
                              )
                            else
                              Icon(
                                Icons.circle,
                                size: 10.sp,
                                color: Colors.greenAccent,
                              ),
                            SizedBox(
                              width: 1.w,
                            ),
                            MyText(
                              text: "${indexNote['type']}",
                              textSize: 10.sp,
                              textColor: Colors.greenAccent,
                              textOverflow: TextOverflow.ellipsis,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
