import 'package:blind_app/favorite.dart';
import 'package:flutter/material.dart';
import 'package:blind_app/database.dart';
import 'package:blind_app/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import 'homePage.dart';


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _age;
  late TextEditingController _email;
  late TextEditingController _job;
  late TextEditingController _salary;
  var h, w;

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController(text: "");
    _age = TextEditingController(text: "");
    _phone = TextEditingController(text: "");
    _email = TextEditingController(text: "");
    _job = TextEditingController(text: "");
    _salary = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
backgroundColor: Colors.black,
      appBar: AppBar(

        backgroundColor: Colors.black,
        title: const Text("Add User",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage1(),));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => favorite(),));

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
                    controller: _age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Age : ',
                      labelText: 'Age : ',
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
                    controller: _phone,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Phone : ',
                      labelText: 'Phone : ',
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
                    controller: _email,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixText: 'E-mail : ',
                      labelText: 'E-mail : ',
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
                    controller: _job,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixText: 'Job: ',
                      labelText: 'Job : ',
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
                    controller: _salary,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixText: 'Salary: ',
                      labelText: 'Salary : ',
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
              margin: EdgeInsets.fromLTRB(w / 3, 0, w / 3, h / 3),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              width: w / 3,
              height: h / 20,
              child: const Center(child: Text("Add User")),
            ),
            onTap: () {
              createUser().then((value) => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'User added successfully!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage1())),
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

  createUser() async {
    final user = User(
        id: M.ObjectId(),
        name: _name.text,
        age: int.parse(_age.text),
        phone: int.parse(_phone.text),
    email: _email.text,
      job: _job.text,
      salary: double.parse(_salary.text),
    );
    await MongoDatabase.insert(user);
  }
}

////////////jkkkkkkkkkk////////////////////////////////////////////////////////////lx;/aK