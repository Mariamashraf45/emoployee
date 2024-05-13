import 'package:blind_app/department/departmentScreen.dart';
import 'package:blind_app/department/update.dart';
import 'package:blind_app/models/department.dart';
import 'package:blind_app/project/home.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../database.dart';
import '../models/project.dart';
import '../users/homePage.dart';

class proCard extends StatefulWidget {
  final Map<String, dynamic> project;
  const proCard({Key? key, required this.project}) : super(key: key);
  @override
  State<proCard> createState() => _proCardState();
}

class _proCardState extends State<proCard> {
  late Project1 p;
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
                    child: Text(widget.project["name"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),

                    child: Text('Start Time: ${widget.project["startTime"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('End Time: ${widget.project["endTime"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('Status: ${widget.project["status"]}', style: const TextStyle(fontSize: 15, )),),



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
                      print(widget.project["_id"].toString());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateDep(id: widget.project["_id"]))).then((value) => setState(() {}));
                    }
                  },
                ),

                GestureDetector(

                  child: const Icon(Icons.delete,color: Colors.grey,),
                  onTap: () async {
                    await MongoDatabase.deleteproj(widget.project["_id"]);
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Project deleted successfully!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const homepro())),
                              child:
                              const Text('OK', textAlign: TextAlign.center),
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
