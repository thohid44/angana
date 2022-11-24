import 'dart:convert';

import 'package:angana/model/student_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {

void initState(){
  fetchstudentCourseModel();
  super.initState(); 
}
  Future<List<StudentCourseModel>> fetchstudentCourseModel() async{
    final  jsonData =  await rootBundle.rootBundle.loadString('assets/student_course.json'); 

    final list = json.decode(jsonData.toString()) as List<dynamic>; 
    
    return list.map((e) => StudentCourseModel.fromJson(e)).toList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Home"),),
      body: Column(
        children: [ 
          SizedBox(height: 30.h,),
          Container(
            padding: EdgeInsets.only(left: 15.w, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text("Student Name: Angana Barua",
            style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.w600),),
          ), 
          Container(
                padding: EdgeInsets.only(left: 15.w),
                 alignment: Alignment.centerLeft,
            child: Text("Student Roll: 1234565", 
            style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ), 


        ],
      )
    );
  }

  
}
