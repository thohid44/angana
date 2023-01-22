import 'package:angana/views/Teacher/routine.dart';
import 'package:angana/views/Teacher/std_attend_brif_specific_day_report.dart';
import 'package:angana/views/Teacher/std_attend_short_specific_day_report.dart';
import 'package:angana/views/Teacher/student_specific_data.dart';
import 'package:angana/views/Teacher/student_specific_data_details.dart';
import 'package:angana/views/Teacher/teacher_total_cls_held_previous.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Select Option"), value: "Select Option"),
      const DropdownMenuItem(
          child: Text("Total Class Held Privious"),
          value: "Total Class Held Privious"),
      const DropdownMenuItem(
          child: Text("Specific Student Data"), value: "Specific Student Data"),
    ];
    return menuItems;
  }

  String selectedValue = 'Select Option';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("History"),
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAttendShortReport()));
                },
                title: Text("Student Attendance Short Report"),
              ),
            ),
          ),
            Card(
            child: Container(
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAttendBrifReport()));
                },
                title: Text("Student Attendance Brif Report"),
              ),
            ),
          ),
          Card(
            child: Container(
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherTotalClsHelpPrevious()));
                },
                title: Text("Total Class Held Privious"),
              ),
            ),
          )
          ,
          Card(
            child: Container(
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentSpecificData()));
                },
                title: Text("Specific Student Short Data"),
              ),
            ),
          ),
           Card(
            child: Container(
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentSpecificDataDetails()));
                },
                title: Text("Specific Student Details Data"),
              ),
            ),
          ),
          Card(
            child: Container(
              child: ListTile(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Routine()));
                },
                title: Text("Class Routine"),
              ),
            ),
          )
        ],
      )
    );
  }
}
