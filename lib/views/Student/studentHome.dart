import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_session_course_response.dart';
import 'package:angana/views/Student/student_show_course.dart';
import 'package:angana/views/Student/student_specific_attendance_show.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  void initState() {
    fetchstudentCourseModel();
    super.initState();
  }
  final _box = GetStorage();
  var client = http.Client();
  var selector;
  List<StudentSessionCourseResponse> std_course_list = [];

  Future<List<StudentSessionCourseResponse>> fetchstudentCourseModel() async {
    var response = await client.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Student/SessionCourse?user=1703310201452&sessionID=170&programID=1"));
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in res) {
        StudentSessionCourseResponse list =
            StudentSessionCourseResponse.fromJson(item);
        std_course_list.add(list);
      }
      return std_course_list;
    }
    return std_course_list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Home"),
        ),
        body: Column(
         
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.w, bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Student Name: ${_box.read(ApiUrl.stdName)}",
                style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.w),
              alignment: Alignment.centerLeft,
              child: Text(
                "Student Roll: ${_box.read(ApiUrl.studentId)}",
                style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
 SizedBox(height: 30.h,), 

InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentAttendaceShow()));
  },
  child:   Container(
  
    width: double.infinity.w,
  
    height: 50.h,
  
    margin: EdgeInsets.symmetric(horizontal: 30.w),
  
                padding: EdgeInsets.only(left: 15.w),
  
                alignment: Alignment.center,
  
                decoration: BoxDecoration(
  
                  color: Colors.deepPurple
  
                ),
  
                child: Text(
  
                  "Click Attend",
  
                  style: TextStyle(
  
                      fontSize: 17.sp,
  
                      color: Colors.white,
  
                      fontWeight: FontWeight.w600),
  
                ),
  
              ),
),

 SizedBox(height: 30.h,), 

            // Container(
            //   child: Expanded(
            //     child: FutureBuilder(
            //         future: fetchstudentCourseModel(),
            //         builder: ((context, snapshot) {
            //           if (snapshot.connectionState == ConnectionState.done) {
            //             return ListView.builder(
            //               itemCount: std_course_list.length,
            //               itemBuilder: (context, index) {
            //                 return ListTile(
            //                   title: Text(
            //                       std_course_list[index].course.toString()),
            //                 );
            //               },
            //             );
            //           }
            //           return Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         })),
            //   ),
            // )
          ],
        ));
  }
}
