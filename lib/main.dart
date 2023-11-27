import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:today_notes/business_logic/cubit/app_cubit.dart';
import 'package:today_notes/core/my_bloc_observer.dart';
import 'package:today_notes/presentation/screens/home_page.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Today notes',
            home: HomePage(),
          );
        },
      ),
    );
  }
}
