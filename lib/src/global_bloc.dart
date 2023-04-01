import 'dart:convert';

import 'models/medicine.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBloc {
  late BehaviorSubject<List<Medicine>> _medicineList$;
  BehaviorSubject<List<Medicine>> get medicineList$ => _medicineList$;

  GlobalBloc() {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicineList();
  }

  Future removeMedicine(Medicine toRemove) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> medicineList = [];

    var blocList = _medicineList$.value;
    blocList.removeWhere(
        (medicine) => medicine.medicineName == toRemove.medicineName);

    for(int i=0;i<(24/toRemove.interval).floor();i++){
      flutterLocalNotificationsPlugin.cancel(int.parse(toRemove.notificationIDs[i]));
    }

    if (blocList.isNotEmpty) {
      for (var blocMedicine in blocList) {
        String medicineJson = jsonEncode(blocMedicine.toJson());
        medicineList.add(medicineJson);
      }
    }
    sharedUser.setStringList('medicines', medicineList);
    _medicineList$.add(blocList);
  }

  Future updateMedicineList(Medicine newMedicine) async {
    var blocList = _medicineList$.value;
    blocList.add(newMedicine);
    _medicineList$.add(blocList);
    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineList.add(newMedicineJson);
    } else {
      medicineList = sharedUser.getStringList('medicines')!;
      medicineList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineList);
  }

  Future makeMedicineList() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];
    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        Map<String,dynamic> userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      _medicineList$.add(prefList);
    }
  }

}
