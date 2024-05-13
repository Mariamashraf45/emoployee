import 'package:blind_app/home.dart';
import 'package:blind_app/test.dart';
import 'package:flutter/material.dart';
import 'package:blind_app/department/departmentComponent.dart';
import '../database.dart';
import '../favorite.dart';
import 'adddep.dart';


class departHome extends StatefulWidget {
  const departHome({super.key});

  @override
  State<departHome> createState() => _departHomeState();
}

class _departHomeState extends State<departHome> {
  @override
  late List<Map<String, dynamic>> sm;
  late List<String> names = [];

  void getData() async {
    await MongoDatabase.getdep().forEach((c) => {print(c.toString())});
  }

  var h, w, s;
  @override
  Widget build(BuildContext context) {
    s = MediaQuery.of(context).size;
    h = s.height;
    w = s.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const add()));
          },
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0XFFBDBDBD))),
          backgroundColor: Colors.grey[400],
          child:
              Icon(color: Colors.black, Icons.add, size: 30)),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Home() ,));
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Department",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body:
      Stack(
        children: [
          Center(child: Image.asset('assets/images/back4.jpg')),
          ListView(
            children: <Widget>[
              FutureBuilder(
                  future: MongoDatabase.getDocuments1(),
                  builder: (buildContext, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      // If data is null, handle it accordingly (e.g., show a message)
                      return CircularProgressIndicator();
                    }
                    sm = snapshot.data;
                    if (snapshot.hasError) {
                      return const Text("Loading");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      // While data is being fetched, show a loading indicator
                      return Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData) {
                      return Container(
                        child: const Center(
                          child: Text("Waiting..."),
                        ),
                      );
                    } else {
                      return SizedBox(
                          height: h / 1.3,
                          child: ListView.builder(
                              itemCount: sm.length,
                              itemBuilder: (context, index) {
                                return depCard == null
                                    ? Center(child: CircularProgressIndicator())
                                    : depCard(department: sm[index]);
                              }));
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
