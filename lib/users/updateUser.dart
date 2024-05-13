import 'package:blind_app/favorite.dart';
import 'package:flutter/material.dart';
import 'package:blind_app/database.dart';
import 'package:blind_app/users/homePage.dart';
import 'package:blind_app/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;


class UpdateUser extends StatefulWidget {
  final M.ObjectId id;
  // final User u;
  const UpdateUser({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late TextEditingController _name = TextEditingController(text: "");
  late TextEditingController _phone = TextEditingController(text: "");
  late TextEditingController _age = TextEditingController(text: "");
  late TextEditingController _email = TextEditingController(text: "");
  late TextEditingController _job = TextEditingController(text: "");
  late TextEditingController _salary = TextEditingController(text: "");
  var h, w;
  late Map<String, dynamic> use;
  late User u;

  @override
  void initState() {
    print(widget.id);
    initializeUser();
  }

  void initializeUser() async {
    use = await MongoDatabase.currentuser(widget.id);
    setState(() {
      _name = TextEditingController(text: use["name"]);
      _age = TextEditingController(text: use["age"].toString());
      _phone = TextEditingController(text: use["phone"].toString());
      _email = TextEditingController(text: use["email"].toString());
      _job = TextEditingController(text: use["job"].toString());
      _salary = TextEditingController(text: use["salary"].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Update User", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
      ),
       backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
          color: Colors.grey,


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
                width: 120,
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
                Container(color: Colors.grey,
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
                Container(color: Colors.grey,
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
                Container(color: Colors.grey,
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
                  height: h / 30,
                ),
                Container(color: Colors.grey,
                  child: TextField(
                    autofocus: true,
                    controller: _email,
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
                Container(color: Colors.grey,
                  child: TextField(
                    autofocus: true,
                    controller: _job,
                    decoration: InputDecoration(
                      prefixText: 'Job : ',
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
                Container(color: Colors.grey,
                  child: TextField(
                    autofocus: true,
                    controller: _salary,
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
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(w / 3, 0, w / 3, h / 3),
              width: w / 3,
              height: h / 20,
              child: const Center(child: Text("Update User")),
            ),
            onTap: () async {
              MongoDatabase.deleteUser(widget.id);

              updateUser().then((value) => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'User updated!!!',
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
              print('update 4');
            },
          )
        ],
      ),
    );
  }

  updateUser() async {
    final user = User(
        id: M.ObjectId(),
        name: _name.text,
        age: int.parse(_age.text),
        phone: int.parse(_phone.text),
    email: _email.text,
        salary: double.parse(_salary.text),
    job: _job.text);
    await MongoDatabase.insert(user);
  }
}
