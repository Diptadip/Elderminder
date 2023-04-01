import 'package:flutter/material.dart';
import 'src/global_bloc.dart';
import 'src/constants.dart';
import 'package:provider/provider.dart';
import 'src/ui/Homepage.dart';

void main() {
  runApp(MedicineReminderApp());
}

class MedicineReminderApp extends StatefulWidget{
  @override
  _MedicineReminderAppState createState() => _MedicineReminderAppState();
}

class _MedicineReminderAppState extends State<MedicineReminderApp> {

  late GlobalBloc globalBloc;

  void initState(){
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          brightness: Brightness.light,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
