import 'package:blind_app/department/departmentScreen.dart';
import 'package:blind_app/department/update.dart';
import 'package:blind_app/models/department.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../database.dart';
import '../users/homePage.dart';

class depCard extends StatefulWidget {
  final Map<String, dynamic> department;
  const depCard({Key? key, required this.department}) : super(key: key);
  @override
  State<depCard> createState() => _depCardState();
}

class _depCardState extends State<depCard> {
  late Department d;
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
                    child: Text(widget.department["name"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),

                    child: Text('Curent Manager: ${widget.department["Curent_manager"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('location: ${widget.department["location"]}', style: const TextStyle(fontSize: 15, )),),
                  Container(
                    margin: EdgeInsets.fromLTRB(w/20,h/100, 0,0),
                    child: Text('NumEmployee: ${widget.department["NumEmployee"]}', style: const TextStyle(fontSize: 15, )),),



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
                      print(widget.department["_id"].toString());
                     Navigator.pushReplacement(
                         context,
                       MaterialPageRoute(
                             builder: (context) => UpdateDep(id: widget.department["_id"]))).then((value) => setState(() {}));
                    }
                  },
                ),

                GestureDetector(
                  child: const Icon(Icons.delete,color: Colors.grey,),
                  onTap: () async {
                    await MongoDatabase.deleteDepartment1(widget.department["_id"]);
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Department deleted successfully!!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const departHome())),
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
