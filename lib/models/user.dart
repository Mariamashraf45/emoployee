import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String name;
  final int age;
  final int phone;
  final String email;
  final String job;
  final double salary;

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.phone,
      required this.email,
        required this.job,
        required this.salary
      });

  Map<String, dynamic> toMap() {
    print("error1");
    return {"_id": id, "name": name, "age": age, "phone": phone, "email":email, "job":job,"salary":salary};
  }

  User.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        age = map['age'],
        phone = map['phone'],
        email = map['email'],
  salary = map['salary'],
        job = map['job'];

}
