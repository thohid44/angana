import 'package:angana/model/totalclass_held.dart';
import 'package:angana/views/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class TeacherTotalClsHelpPrevious extends StatefulWidget {
  const TeacherTotalClsHelpPrevious({super.key});

  @override
  State<TeacherTotalClsHelpPrevious> createState() =>
      _TeacherTotalClsHelpPreviousState();
}

class _TeacherTotalClsHelpPreviousState
    extends State<TeacherTotalClsHelpPrevious> {
  // Future<TotalClassHeld> getTotalClass() async {
  //   var response = await http.get(Uri.parse("http://puc.ac.bd:8098/api/StudentAttendance/shortReport?sessionCourseId=6818&date=10-19-2022&deptId=1"));

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total Class Help Previous")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 25.sp,
              ),
              alignment: Alignment.centerLeft,
              child: customText(
                  "Total Class: 23", 17.0, Colors.black, FontWeight.bold),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 25.sp, top: 15.sp),
              alignment: Alignment.centerLeft,
              child: customText(
                  "Total Present: 19", 17.0, Colors.black, FontWeight.bold),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 25.sp, top: 15.sp),
              alignment: Alignment.centerLeft,
              child: customText(
                  "Total Absent: 4", 17.0, Colors.black, FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
