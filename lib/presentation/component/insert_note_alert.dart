import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:today_notes/business_logic/cubit/app_cubit.dart';
import 'package:today_notes/presentation/styles/colors.dart';
import 'package:today_notes/presentation/widgets/default_text_button.dart';
import 'package:today_notes/presentation/widgets/my_text.dart';
import 'package:today_notes/presentation/widgets/my_text_form_feild.dart';

class InsertNoteAlert extends StatefulWidget {
  const InsertNoteAlert({
    Key? key,
  }) : super(key: key);

  @override
  State<InsertNoteAlert> createState() => _InsertNoteAlertState();
}

class _InsertNoteAlertState extends State<InsertNoteAlert> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController = TextEditingController();

  late final TextEditingController _discriptionController =
      TextEditingController();




  late final TextEditingController _typeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    late final TextEditingController _dateController =
        TextEditingController(text: AppCubit.get(context).dateSelectedByUser);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ShowDateSelectedState) {
          setState(() {

          });
        }
      },
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Dialog(
              backgroundColor: white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Container(
                color: white,
                padding: EdgeInsets.only(
                    left: 3.w, right: 3.w, bottom: 2.h, top: 4.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyTextFormFeild(
                          controller: _titleController,
                          labelText: 'Title for Note',
                          textInputType: TextInputType.text,
                          prefixIcon: const Icon(Icons.title),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "can't empty";
                            }
                            return null;
                          },
                          borderColor: const Color(0xffDC4D3F),
                          textColor: const Color(0xffDC4D3F),
                        ),
                        MyTextFormFeild(
                          controller: _discriptionController,
                          labelText: 'Small Discription of the Note',
                          textInputType: TextInputType.text,
                          prefixIcon: const Icon(Icons.data_object),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "can't empty";
                            }
                            return null;
                          },
                          borderColor: const Color(0xffDC4D3F),
                          textColor: const Color(0xffDC4D3F),
                        ),
                        MyTextFormFeild(
                          controller: _dateController,
                          labelText: 'Date of the Note',
                          hintText: 'DD/MM/YYYY',
                          textInputType: TextInputType.text,
                          prefixIcon: const Icon(Icons.date_range_outlined),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "can't empty";
                            }
                            return null;
                          },
                          borderColor: const Color(0xffDC4D3F),
                          textColor: const Color(0xffDC4D3F),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.date_range,
                              color:const Color(0xffDC4D3F)
                            ),
                            onPressed: () async {
                              DateTime? dateSelected = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2050));

                              if (dateSelected != null && mounted) {
                                await AppCubit.get(context)
                                    .showDateSelectedByUser(dateSelected);
                              } else {
                                return;
                              }
                            },
                          ),
                        ),
                        MyTextFormFeild(
                          controller: _typeController,
                          labelText: 'Type the Note',
                          textInputType: TextInputType.text,
                          prefixIcon: const Icon(Icons.type_specimen_outlined),
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "can't empty";
                            }
                            return null;
                          },
                          borderColor: const Color(0xffDC4D3F),
                          textColor: const Color(0xffDC4D3F),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await AppCubit.get(context).insertNote(
                                      date: _dateController.text,
                                      discription: _discriptionController.text,
                                      title: _titleController.text,
                                      type: _typeController.text);

                                  if (mounted) {
                                    Fluttertoast.showToast(
                                        msg: "insert note save successfully",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green[900],
                                        textColor: darkBlue,
                                        fontSize: 14.sp);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: MyText(
                                text: "Save",
                                textColor: const Color(0xffDC4D3F),
                                weight: FontWeight.bold,
                                textSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            DefaultTextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: MyText(
                                text: "Cancel",
                                textColor: const Color(0xffDC4D3F),
                                weight: FontWeight.bold,
                                textSize: 14.sp,
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
