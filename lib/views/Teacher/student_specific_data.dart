import 'dart:convert';

import 'package:angana/model/StdClassDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
class StudentSpecificData extends StatefulWidget {
  const StudentSpecificData({super.key});

  @override
  State<StudentSpecificData> createState() => _StudentSpecificDataState();
}

class _StudentSpecificDataState extends State<StudentSpecificData> {

  
  Future<StdClassDetailsModel> studentFetchbyCourse() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/getStudentClassDetails?studentId=3553&sessionCourseId=6818&deptId=1"));

    var jsonData = jsonDecode(res.body.toString());
    print(jsonData);
    if (res.statusCode == 200) {
      return StdClassDetailsModel.fromJson(jsonData);
    } else {
      return StdClassDetailsModel.fromJson(jsonData);
    }
  }

  void initState() {
    studentFetchbyCourse();
    super.initState();
  }
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Select Course"), value: "Select Course"),
      const DropdownMenuItem(
          child: Text("Total Class Held Privious"),
          value: "Total Class Held Privious"),
      const DropdownMenuItem(
          child: Text("Specific Student Data"), value: "Specific Student Data"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItem {
    List<DropdownMenuItem<String>> menuItem = [
      const DropdownMenuItem(
          child: Text("Student Id"), value: "Student Id"),
      const DropdownMenuItem(
          child: Text("Total Class Held Privious"),
          value: "Total Class Held Privious"),
      const DropdownMenuItem(
          child: Text("Specific Student Data"), value: "Specific Student Data"),
    ];
    return menuItem;
  }

  String selectedValue = 'Select Course';
  String selectedId = 'Student Id';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Specific Data"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.h,), 
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              height: 45.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Colors.grey)),
              child: DropdownButton(
                  underline: SizedBox(),
                  value: selectedValue,
                  style: TextStyle(color: Colors.black, fontSize: 17.sp),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      if (selectedValue == 'Total Class Held Privious') {
                      } else if (selectedValue == 'Specific Student Data') {}
                    });
                  },
                  items: dropdownItems)),
          SizedBox(
            height: 20.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              height: 45.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Colors.grey)),
              child: DropdownButton(
                borderRadius: BorderRadius.circular(20.r),
                  underline: SizedBox(),
                  value: selectedId,
                  style: TextStyle(color: Colors.black, fontSize: 17.sp),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedId = newValue!;
                      if (selectedValue == 'Total Class Held Privious') {
                      } else if (selectedValue == 'Specific Student Data') {}
                    });
                  },
                  items: dropdownItem)),
                  SizedBox(height: 30.h,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.centerLeft,
            child: Column(
            
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ID:1234",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                  child: Text(
                    "Name:",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                  child: Text(
                    "Total Absent:",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
