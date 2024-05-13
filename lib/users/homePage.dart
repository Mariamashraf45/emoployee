import 'package:blind_app/department/departmentScreen.dart';
import 'package:blind_app/favorite.dart';
import 'package:blind_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:mongo_dart/mongo_dart.dart';

import 'addUser.dart';
import 'employeeComponent.dart';
import '../database.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late List<Map<String, dynamic>> sm ;
  late List<String> names = [];

  void getData() async {
    await MongoDatabase.getDocs().forEach((c) => {print(c.toString())});
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const AddUser()));
          },
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0XFFBDBDBD))),
          backgroundColor: Colors.grey[400],
          child:
              Icon(color: Colors.black, Icons.person_add_alt_sharp, size: 30)),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
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
      appBar: AppBar(backgroundColor: Colors.black,
        title: const Text(
          "Employee Management System",
          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => departHome(),));}, icon: Icon(Icons.local_fire_department,color: Colors.grey,))],

      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/back4.jpg')),
          ListView(
            children: <Widget>[
              FutureBuilder(
                  future: MongoDatabase.getDocuments(),
                  builder: (buildContext, AsyncSnapshot snapshot) {
                     if (snapshot.data == null) {
                    // If data is null, handle it accordingly (e.g., show a message)
                    return CircularProgressIndicator();
                    }
                    sm = snapshot.data;
                    if (snapshot.hasError) {
                      return const Text("Loading");
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      // While data is being fetched, show a loading indicator
                      return Center(child: CircularProgressIndicator());
                    }
                    else if (!snapshot.hasData) {
                      return Container(
                        child: const Center(
                          child: Text("Waiting..."),
                        ),
                      );
                    }
                    else {
                      return SizedBox(
                          height: h / 1.3,
                          child: ListView.builder(
                              itemCount: sm.length,
                              itemBuilder: (context, index) {
                              return UserCard == null ? CircularProgressIndicator() :
                                  UserCard(user: sm[index]);
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
