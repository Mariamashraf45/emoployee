import 'package:flutter/material.dart';
import 'package:blind_app/users/updateUser.dart';

import '../database.dart';
import  'homePage.dart';
import '../models/user.dart';

class UserCard extends StatefulWidget {
  final Map<String, dynamic> user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  late User u;
  var h, w;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(w/30, h/50, w/30, 0),
      height: h/5,
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(30)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/50, 0,0),
                    child: Text(widget.user["name"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    
                    child: Text('Age: ${widget.user["age"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('Phone: ${widget.user["phone"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('E-mail: ${widget.user["email"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('Job: ${widget.user["job"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('Salary: ${widget.user["salary"]}', style: const TextStyle(fontSize: 15, )),),
                ],
              
              ),
            ),
          ),
          // Container(width: w/3,),
          Container(
            margin: EdgeInsets.fromLTRB(0,0,w/30,0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: const Icon(Icons.edit,color: Colors.grey,),
                onTap: () {
                  {
                    print(widget.user["_id"].toString());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateUser(id: widget.user["_id"]))).then((value) => setState(() {}));
                  }
                },
              ),
              GestureDetector(
                child: const Icon(Icons.delete,color: Colors.grey,),
                onTap: () async {
                  await MongoDatabase.deleteUser(widget.user["_id"]);
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'User deleted successfully!!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const HomePage1())),
                            child:
                            const Text('OK', textAlign: TextAlign.center),
                          ),
                        ],
                      ));
                },
              ),
              GestureDetector(
                child: const Icon(Icons.favorite,color: Colors.red,),
                onTap: () async {
                },
              ),

            ],
        ),
          ),
        ],
      ),
    );
  }

  void getUser() async {
    u = await MongoDatabase.currentuser(widget.user["_id"]);
  }
}
