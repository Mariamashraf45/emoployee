import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class us extends StatelessWidget {
  const us({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(
              'About Us ',
              style: TextStyle(fontSize: 45, color: Colors.white),
            ),
            SizedBox(height: 50,),
            Text('Company Services: Mobile app development, web application development, technology solutions for small and medium-sized enterprises', style: TextStyle(color: Colors.white60, fontSize: 16),),

            SizedBox(height: 50,),
            Text('Employee Management System (EMS) that acts as a central hub for managing employee information. Supervisors and managers can easily access and update employee data, including adding new hires, tracking performance, and handling leave requests. The system also boasts a user-friendly interface for employees to access their own information. This fosters better communication and transparency between management and staff, ultimately improving overall team efficiency and productivity.', style: TextStyle(color: Colors.white60, fontSize: 16),),
          SizedBox(
            height: 50,
          ),
            Column(
              children: [
                Text('Date of Establishment: July 15, 2010', style: TextStyle(fontSize: 22, color: Colors.white54),),
                Text('Company Owner: Yusuf Ahmed', style: TextStyle(fontSize: 22, color: Colors.white54),),
                Text('Number of Employees: 50', style: TextStyle(fontSize: 22, color: Colors.white54),),
                Text('Location: Alexandria', style: TextStyle(fontSize: 22, color: Colors.white54),),
              ],

            )

          ],
        )),
      ),
    );
  }
}
