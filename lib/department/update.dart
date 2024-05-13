import 'package:blind_app/favorite.dart';
import 'package:flutter/material.dart';
import 'package:blind_app/database.dart';
import 'package:blind_app/users/homePage.dart';
import 'package:blind_app/models/department.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import '../models/department.dart';
import 'departmentScreen.dart';

class UpdateDep extends StatefulWidget {
  final M.ObjectId id;

  const UpdateDep({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateDep> createState() => _UpdateDepState();
}

class _UpdateDepState extends State<UpdateDep> {
  late TextEditingController _name = TextEditingController(text: "");
  late TextEditingController _Currentmanger = TextEditingController(text: "");
  late TextEditingController _location = TextEditingController(text: "");
  late TextEditingController _Numemployee = TextEditingController(text: "");
  var h, w;
  late Map<String, dynamic> dep;
  late Department d;

  @override
  void initState() {
  print(widget.id);
    initializeDep();
  }

  void initializeDep() async {
    dep = await MongoDatabase.currentdepartment(widget.id);
    print('error');
    setState(() {
      _name = TextEditingController(text: dep["name"]);
      _location = TextEditingController(text: dep["location"].toString());
      _Currentmanger =
          TextEditingController(text: dep["Current_manger"].toString());
      _Numemployee = TextEditingController(text: dep["NumEmployee"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Update Departmant",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage1(),
                      ));
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Text(
                'Home',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                width: 100,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => favorite(),
                        ));
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.black,
                    size: 30,
                  )),
              Text(
                'Favorite',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          )),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(w / 30),
            padding: EdgeInsets.all(w / 20),
            child: Column(
              children: [
                Container(
                  height: h / 100,
                ),
                Container(
                  color: Colors.grey,
                  child: TextField(
                    controller: _name,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixText: 'Name : ',
                      labelText: 'Name : ',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(w / 60),
                    ),
                  ),
                ),
                Container(
                  height: h / 50,
                ),
                Container(
                  color: Colors.grey,
                  child: TextField(
                    autofocus: true,
                    controller: _Currentmanger,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixText: 'Current Manger : ',
                      labelText: 'Cirrent Manger: ',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(w / 60),
                    ),
                  ),
                ),
                Container(
                  height: h / 50,
                ),
                Container(
                  color: Colors.grey,
                  child: TextField(
                    controller: _location,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixText: 'Location : ',
                      labelText: 'Location : ',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.all(w / 60),
                    ),
                  ),
                ),
                Container(
                  height: h / 30,
                ),
                Container(
                  color: Colors.grey,
                  child: TextField(
                    autofocus: true,
                    controller: _Numemployee,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Number of Employee : ',
                      labelText: 'Number Of Employee : ',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.all(w / 60),
                    ),
                  ),
                ),
                Container(
                  height: h / 50,
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(w / 3, 0, w / 3, h / 3),
              width: w / 3,
              height: h / 20,
              child: const Center(child: Text("Update Department")),
            ),
            onTap: () async {
              MongoDatabase.deleteDepartment1(widget.id);
              updateDepartment().then((value) => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Department updated!!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const departHome())),
                            child:
                                const Text('OK', textAlign: TextAlign.center),
                          ),
                        ],
                      )));
            },
          )
        ],
      ),
    );
  }

  updateDepartment() async {
    final dep = Department(
        id: M.ObjectId(),
        name: _name.text,
        NumEmployee: int.parse(_Numemployee.text),
        Curent_manager: _Currentmanger.text,
        location: _location.text);
    await MongoDatabase.insert1(dep);
  }
}
