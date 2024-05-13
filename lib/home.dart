import 'package:blind_app/aboutUs.dart';
import 'package:blind_app/department/departmentScreen.dart';
import 'package:blind_app/project/home.dart';
import 'package:blind_app/test.dart';
import 'package:blind_app/users/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(backgroundColor: Colors.black,),
backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(' Employee Mangment System',style: TextStyle(color: Colors.white,fontSize: 35),),
              SizedBox(height: 8,),
             // Text(' Welcom in our Web Site',style: TextStyle(color: Colors.grey[500],fontSize: 25),),
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => us(),));
                  }, icon: Icon(Icons.help_outlined,size: 40,color: Colors.grey[500],)),
                  
                  Text(' Know About Us ',style: TextStyle(color: Colors.grey[500],fontSize: 25),),
                ],
              ),
              SizedBox(height: 25,),
              Stack(
                children: [
                  Center(child: Image.asset('assets/images/back4.jpg')),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage1() ,));},
                            child: Container(
                              height: 90, width: 180,
                              child: Center(child: Text('Employees',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),decoration: BoxDecoration(
                                color: Colors.grey,borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(30),bottomEnd: Radius.circular(30) )
                            ),
                            ),
                          ),
                        ),
                        GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => departHome(),));},
                          child: Container(
                            height: 90, width: 180,
                            child: Center(child: Text('Departments',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),decoration: BoxDecoration(
          
                              color: Colors.grey,borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(30),bottomEnd: Radius.circular(30) )
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => homepro(),));
                          },
                            child: Container(
                              height: 90, width: 180,
                              child: Center(child: Text('Projects',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),decoration: BoxDecoration(
                                color: Colors.grey,borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(30),bottomEnd: Radius.circular(30) )
                            ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
