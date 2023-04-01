import 'package:flutter/material.dart';
import 'contactSharedPref.dart';
import '../constants.dart';
import 'package:smsalert/smsalert.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'dart:io' show Platform;

class Sos extends StatefulWidget {
  @override
  _SosState createState() => _SosState();
}

String locality = " ";
String _name = '';
String _phone = '';
late String _details = '';

class _SosState extends State<Sos> {
  _database() async {
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();

      double? lat = currentLocation.latitude;
      double? lng = currentLocation.longitude;
      //print(lat);
      List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
      locality = placemarks.first.locality.toString();
      print(placemarks.first.locality);
    } catch (e) {
      print("error");
      print(e);
    }
  }

  void displayLocation(String mssg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(mssg+". SMS alert has been sent to your emergency contacts"),
      duration: const Duration(milliseconds: 5000),
    ));
  }

  String sendText() {
    _database();
    print(_details);
    String text = "This is a SOS text. The last know location of the user is ${locality}";
    return text;
  }

  Future<void> main() async {
    //   String? _user = Platform.environment['SMSALERT_ACCOUNT_USERNAME'];
    // String? _pwd = Platform.environment['SMSALERT_ACCOUNT_PASSWORD'];

    /// Your SMSAlert account username and password.
    /// You can skip this block if you store your credentials in environment variables.
    String _user = 'YOUR SMS ALERT USERNAME';
    String _pwd = 'YOUR SMS ALERT PASSWORD';

    /// Create an authenticated SMSAlert sa instance.
    SMSAlert sa = new SMSAlert(_user, _pwd);

    // Send a text message.
    // Returns a Map object (key/value pairs).
    Map? message = await sa.messages.sendsms({
      'text': sendText(), //SMS text
      'sender': 'ElderMinder', // a valid sender ID
      'mobileno': _phone.toString(), // your destination phone number
      'route': 'demo' //to select route
    });

    print(message);
  }

  ContactData cData = ContactData();
  Widget build(BuildContext context) {
    // _database();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        title: Text(
          'SOS',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Center(
            child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'SOS',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Press the button to send an SOS message to your emergency contacts',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (0.15),
            ),
            Container(
              width: 200,
              height: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //main();
                    displayLocation(sendText());                    
                  },
                  child: Icon(
                    Icons.sos,
                    size: 50,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kRedColor,
                    shape: CircleBorder(),
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
