import 'package:flutter/material.dart';
import 'contactSharedPref.dart';
import '../constants.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SosSetup extends StatefulWidget {
  @override
  _SosSetupState createState() => _SosSetupState();
}

class _SosSetupState extends State<SosSetup> {
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String num = "";
  //ContactsList contacts = ContactsList.fromJson(contacts);

  late TextEditingController name1Controller;
  late TextEditingController phone1Controller;
  late TextEditingController name2Controller;
  late TextEditingController phone2Controller;

  String _name = '';
  String _phone = '';
  late String _details = '';

  @override
  void initState() {
    name1Controller = TextEditingController();
    phone1Controller = TextEditingController();
    name2Controller = TextEditingController();
    phone2Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name1Controller.dispose();
    phone1Controller.dispose();
    super.dispose();
  }

  late var dataStore;

  ContactData cData = ContactData();

  // Future<String> _getData() async {
  //   await cData.getJsonData();
  //   print('Data:: ${cData.Data}');
  //   return Data;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        title: Text(
          "Add your SOS contacts",
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
      ),
      body: Container(
        child: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            children: <Widget>[
              PanelTitle(
                title: "Contact Name 1",
                isRequired: true,
              ),
              TextFormField(
                maxLength: 25,
                style: TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                ),
                controller: name1Controller,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: UnderlineInputBorder(),
                ),
              ),
              PanelTitle(
                title: "Contact Number 1",
                isRequired: true,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  num = number.phoneNumber.toString();
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                  if (value) {
                    print(num);
                  }
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: kTextColor),
                textStyle: TextStyle(
                  color: kTextColor,
                ),
                initialValue: number,
                textFieldController: phone1Controller,
                formatInput: true,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: UnderlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              SizedBox(
                height: 20,),
              PanelTitle(
                title: "Contact Name 2",
                isRequired: true,
              ),
              TextFormField(
                maxLength: 25,
                style: TextStyle(
                  fontSize: 16,
                  color: kTextColor,
                ),
                controller: name2Controller,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: UnderlineInputBorder(),
                ),
              ),
              PanelTitle(
                title: "Contact Number 2",
                isRequired: true,
              ),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  num = number.phoneNumber.toString();
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                  if (value) {
                    print(num);
                  }
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: kTextColor),
                textStyle: TextStyle(
                  color: kTextColor,
                ),
                initialValue: number,
                textFieldController: phone2Controller,
                formatInput: true,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: UnderlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Container(
                  width: 220,
                  height: 70,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 20,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () async {
                        //String num = number.toString();
                        print(name1Controller.text);
                        print(phone1Controller.text);
                        dataStore = <String, dynamic>{
                          'name': name1Controller.text,
                          'phone': num,
                        };
                        await cData.saveJsonData(dataStore);
                        cData.getJsonData();
                        // _getData().then((value) {
                        //   _details = value;
                        // });

                        cData.getNameString().then((value) {
                          _name = value;
                        });
                        cData.getPhoneString().then((value) {
                          _phone = value;
                        });
                        //print("Details: ${_name.toString()} : ${_phone.toString()}");
                        if(_name.toString() != '' && _phone.toString() != ''){
                          _details="$_name:$_phone";
                        }
                        //print(_details);
                      }),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Your contacts here \n ${_details}",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key? key,
    required this.title,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: kRedColor),
          ),
        ]),
      ),
    );
  }
}
