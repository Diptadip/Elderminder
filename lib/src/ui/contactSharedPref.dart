import 'dart:convert';
import '../models/contactData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact.dart';

class ContactData {
  var Data;

  Future saveJsonData(jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    //contactData.addEntries(jsonData.entries);
    var saveData = jsonEncode(jsonData);
    await prefs.setString('jsonData', saveData);
  }

  Future<void> getJsonData() async {
    final prefs = await SharedPreferences.getInstance();
    var getData = prefs.getString('jsonData') ?? defaultData;
    print("getData: ${getData}");
    var data = Contact.fromMap(jsonDecode(getData.toString()));
    print("Data: ${jsonDecode(getData.toString())}");
    Data = data;
    print('Name: ${data.name.toString()}');
    print('Phone: ${data.phone.toString()}');
  }

  Future<String> getNameString() async {
    if (Data == null)
      return "Name";
    else
      return Data.name.toString();
  }

  Future<String> getPhoneString() async {
    if (Data == null) return "Phone";
    else return Data.phone.toString();
  }
}
