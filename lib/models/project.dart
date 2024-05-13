import 'package:mongo_dart/mongo_dart.dart';

class Project1 {
  final ObjectId id;
  final String name;
  final String status;
  final int endTime;
  final int startTime;
  const Project1(
      {required this.id,
        required this.name,
        required this.endTime,
        required this.status,
        required this.startTime,
            });

  Map<String, dynamic> toMap() {

    return {"_id": id, "name": name, "endTime": endTime,"startTime": startTime,"status":status };

  }

  Project1.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        id = map['_id'],
        startTime = map['startTime'],
        endTime = map['endTime'],
        status = map['status'];
       }
