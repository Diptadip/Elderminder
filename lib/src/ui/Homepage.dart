import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../global_bloc.dart';
import '../models/medicine.dart';
import 'medicineDetails.dart';
import 'newEntry.dart';
import 'sosSetup.dart';
import 'sos.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        elevation: 0.0,
      ),
      body: Container(
        color: kBackgroundColor,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              //height: 80.0,
          //width: 80.0,
          child: FittedBox(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kRedColor,
                shape: CircleBorder(),
                fixedSize: Size(80, 80)
              ),
              child: const Icon(
                Icons.sos,
                size: 50,
              ),
              onLongPress: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SosSetup()),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sos()),
                );
              },
            ),
          // child: FloatingActionButton(
          //   elevation: 4,
          //   backgroundColor: kRedColor,
          //   child: const Icon(
          //     Icons.sos,
          //   ),
          //   onLongPress: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => SosSetup()),
          //     );
          //   },
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => NewEntry(),
          //   ),
          // );
          //   }
          // ),
        ),
      ),
      SizedBox(
        height: 50,
      ),
      FloatingActionButton(
        elevation: 4,
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        },
      ),
        ],
      )
      //floatingActionButton: 
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: kPrimaryColor,
            offset: Offset(0, 5.5),
          )
        ],
        color: kSecondaryColor,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
      child: Column(
        
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              "Elderminder",
              style: TextStyle(
                fontFamily: "Angel",
                fontSize: 64,
                color: kPrimaryColor,
              ),
            ),
          ),
          const Divider(
            color: kSecondaryColor,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Number of Medicine Reminders",
                style: TextStyle(
                  fontSize: 17,
                  color: kBackgroundColor,
                ),
              ),
            ),
          ),
          StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 5),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? "0" : snapshot.data!.length.toString(),
                    style: const TextStyle(
                      fontFamily: "Neu",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kBackgroundColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Medicine>>(
      stream: _globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Container(
            color: kBackgroundColor,
            child: const Center(
              child: Text(
                "Press + to add a Mediminder\n\nLong press SOS to set up your emergency contacts",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: kTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Container(
            color: kBackgroundColor,
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MedicineCard(snapshot.data![index]);
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard(this.medicine);

  Hero makeIcon(double size) {
    if (medicine.medicineType == "Bottle") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          const IconData(0xf053a, fontFamily: "MaterialIcons"),
          color: kPrimaryColor,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          const IconData(0xe901, fontFamily: "MaterialIcons"),
          color: kPrimaryColor,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          const IconData(0xf0597, fontFamily: "MaterialIcons"),
          color: kPrimaryColor,
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          const IconData(0xe903, fontFamily: "MaterialIcons"),
          color: kPrimaryColor,
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.error,
        color: kPrimaryColor,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: kTextColor,
        splashColor: kTextColor,
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: animation.value,
                      child: MedicineDetails(medicine),
                    );
                  },
                );
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: kTextColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                makeIcon(50.0),
                Hero(
                  tag: medicine.medicineName,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      medicine.medicineName,
                      style: TextStyle(
                          fontSize: 22,
                          color: kBackgroundColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  medicine.interval == 1
                      ? "Every " + medicine.interval.toString() + " hour"
                      : "Every " + medicine.interval.toString() + " hours",
                  style: TextStyle(
                      fontSize: 16,
                      color: kBlackColor,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
