import 'package:blind_app/favorite.dart';
import 'package:blind_app/models/department.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'models/project.dart';
import 'models/user.dart';

class MongoDatabase {
  static var db, collection, coll,proCollection;

  // function to connect the database
  static connect() async {
    // connection to mongodb
    db = await Db.create(
        'mongodb+srv://mariamsadek54:Fo80zLdIFWHSmWbI@cluster0.rmmpjdr.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'); // open the database for changes

// replace mariamsadek54: with your database and Fo80zLdIFWHSmWbI with your password


    await db.open();
    // fetch the collection we want
    collection = db.collection("User");
    proCollection = db.collection("Project1");
    coll = db.collection("Department");
  }

  // function to insert the data
  // this is the create function of the app
  static insert(User user) async {
    await collection.insertAll([user.toMap()]);
  }

  static insert1(Department department) async {
    await coll.insertAll([department.toMap()]);
  }
  static insert2(Project1 project) async {
    await proCollection.insertAll([project.toMap()]);
  }
  // this function is to read the data from db
  // tom read all the documents we need to use the find() function
  static Future<List<Map<String, dynamic>>?> getDocuments() async {
    try {
      final users = await collection.find().toList();
      return users;
    } catch (e) {
      print(e);
    }
  }
  static Future<List<Map<String, dynamic>>?> getDocuments1() async {
    try {
      final department = await coll.find().toList();

      return department;
    } catch (e) {
      print(e);
    }
  }
  static Future<List<Map<String, dynamic>>?> getDocuments2() async {
    try {
      final projects = await proCollection.find().toList();
      return projects;
    } catch (e) {
      print(e);
    }
  }
  static getUsers() async {
    var usersList = await collection.find({}).toList();
    print(usersList);
    return usersList;
  }
  static getdepartment() async {
    var departmentList = await coll.find({}).toList();
    print(departmentList);
    return departmentList;
  }

  static getproject() async {
    var proList = await proCollection.find({}).toList();
    print(proList);
    return proList;
  }
  static getDocs() async {
    final users = await collection.find();
    return users;
  }
  static getdep() async {
    final department = await coll.find();
    return department;
  }
  static getproj() async {
    final pro = await proCollection.find();
    return pro;
  }

  // to find any desired user using user's id we use findOne() method of mongo db
  // further to make changes of the updated data we use save() function
  static update(User user) async {
    var currentUser = await collection.findOne({"_id": user.id});
    currentUser["name"] = user.name;
    currentUser["age"] = user.age;
    currentUser["phone"] = user.phone;
    currentUser["email"] = user.email;
    currentUser["job"] = user.job;
    await collection.save(currentUser);
  }
  static update1(Department department) async {
    var currentDepartment = await collection.findOne({"_id": department.id});
    currentDepartment["name"] = department.name;
    currentDepartment["Curent_manager"] = department.Curent_manager;
    currentDepartment["NumEmployee"] = department.NumEmployee;
    currentDepartment["location"] = department.location;
    await collection.save(currentDepartment);
  }

  static update2(Project1 project) async {
    var currentproj = await proCollection.findOne({"_id": project.id});
    currentproj["name"] = project.name;
    currentproj["status"] = project.status;
    currentproj["endTime"] = project.endTime;
    currentproj["startTime"] = project.startTime;
    await proCollection.save(currentproj);

  }

  // deletion operations are often easy to perform
  static delete(User user) async {
    await collection.remove(where.id(user.id));
  }
  static deleteUser(ObjectId id) async {
    await collection.remove(where.id(id));
  }

  static currentuser(ObjectId id) {
    return collection.findOne({"_id": id});
  }

  static delete1(Department department) async {
    await coll.remove(where.id(department.id));
  }

  static deleteDepartment1(ObjectId id) async {
    await coll.remove(where.id(id));
  }

  static currentdepartment(ObjectId id) {
    return coll.findOne({"_id": id});
  }

  static delete2(Project1 project) async {
    await proCollection.remove(where.id(project.id));
  }
  static deleteproj(ObjectId id) async {
    await proCollection.remove(where.id(id));
  }

  static currentpro(ObjectId id) {
    return proCollection.findOne({"_id": id});
  }

}
