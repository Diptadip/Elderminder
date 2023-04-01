class Medicine {
  final List<dynamic> notificationIDs;
  final String medicineName;
  final int dosage;
  final String medicineType;
  final int interval;
  final String startTime;

  Medicine({
    required this.notificationIDs,
    required this.medicineName,
    required this.dosage,
    required this.medicineType,
    required this.startTime,
    required this.interval,
  });

  String get getName => medicineName;
  int get getDosage => dosage;
  String get getType => medicineType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  Map<String, dynamic> toJson() {
    return {
      "ids": notificationIDs,
      "name": medicineName,
      "dosage": dosage,
      "type": medicineType,
      "interval": interval,
      "start": startTime,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      notificationIDs: json["ids"],
      medicineName: json["name"],
      dosage: json["dosage"],
      medicineType: json["type"],
      interval: json["interval"],
      startTime: json["start"],
    );
  }



}
