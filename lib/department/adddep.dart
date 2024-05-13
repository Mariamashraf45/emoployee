import 'package:blind_app/department/departmentScreen.dart';
import 'package:blind_app/models/department.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../database.dart';
import '../favorite.dart';
import '../users/homePage.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  late TextEditingController _name;
  late TextEditingController _CurrentManger;
  late TextEditingController _location;
  late TextEditingController _NumEmployee;
  var h, w;

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController(text: "");
    _CurrentManger = TextEditingController(text: "");
    _location = TextEditingController(text: "");
    _NumEmployee = TextEditingController(text: "");

  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.black,
        title: const Text("Add Deparment",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage1(),));
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.grey[400],
                  size: 30,
                ),
              ),
              Text(
                'Home',
                style: TextStyle(color: Colors.grey[400], fontSize: 18),
              ),
              SizedBox(
                width: 100,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => favorite(),));

                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.grey[400],
                    size: 30,
                  )),
              Text(
                'Favorite',
                style: TextStyle(color: Colors.grey[400], fontSize: 18),
              ),
            ],
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset('assets/images/dep',),
          ),
          Container(

            margin: EdgeInsets.all(w / 30),
            padding: EdgeInsets.all(w / 20),
            child: Column(
              children: [
                Container(
                  height: h / 100,
                ),
                Container(color: Colors.grey[100],

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
                Container(color: Colors.grey[100],
                  child: TextField(
                    autofocus: true,
                    controller: _CurrentManger,
                    decoration: InputDecoration(
                      prefixText: 'Current Manger: ',
                      labelText: 'Current Manger : ',
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
                  color: Colors.grey[100],
                  child: TextField(
                    controller: _location,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixText: 'Location : ',
                      labelText: 'location : ',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.all(w / 60),
                    ),
                  ),
                ),
                Container(
                  height: h / 50,
                ),
                Container(
                  color: Colors.grey[100],
                  child: TextField(
                    controller: _NumEmployee,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Number of Employee : ',
                      labelText: 'Number of Employee : ',
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
                  height: h / 50,
                ),
              ],
            ),
          ),


          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(w / 3, 0, w / 3, h / 3),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              width: w / 3,
              height: h / 20,
              child: const Center(child: Text("Add Department")),
            ),
            onTap: () {
              createDepartmen().then((value) => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text(
                      'Department added successfully!',
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

  createDepartmen() async {
    final department = Department(
      id: M.ObjectId(),
      name: _name.text,
      location: _location.text,
      NumEmployee: int.parse(_NumEmployee.text),
      Curent_manager: _CurrentManger.text,

    );
    await MongoDatabase.insert1(department);
  }
  }

