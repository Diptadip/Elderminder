import 'dart:convert';
class Contact{
  final String name;
  final String phone; 

  Contact(
    this.name,
    this.phone,
  );

  Contact copyWith({
    String? name,
    String? phone,
  }) {
    return Contact(
      name ?? this.name,
      phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      map['name'] as String,
      map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Contact(name: $name, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Contact &&
      other.name == name &&
      other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ phone.hashCode;
}