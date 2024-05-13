import 'package:mongo_dart/mongo_dart.dart';

class Department {
  final ObjectId id;
  final String name;
  final int NumEmployee;
  final String Curent_manager;
  final String location;

  const Department(
      {required this.id,
        required this.name,
        required this.Curent_manager,
        required this.location,
        required this.NumEmployee,

      });

  Map<String, dynamic> toMap() {
    print("error1");
    return {"_id": id, "name": name, "Curent_manager": Curent_manager, "location": location, "NumEmployee":NumEmployee};


  }

  Department.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        NumEmployee  = map['NumEmployee'],
        Curent_manager = map['Curent_manager'],
        location = map['location'];

}
