import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_session_course_response.dart';
import 'package:angana/views/student_attendance_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class StudentShowCourse extends StatefulWidget {
  const StudentShowCourse({super.key});

  @override
  State<StudentShowCourse> createState() => _StudentShowCourseState();
}

class _StudentShowCourseState extends State<StudentShowCourse> {
  var selector;
  List<StudentSessionCourseResponse> std_course_list = [];

  Future<List<StudentSessionCourseResponse>> fetchstudentCourseModel() async {
    
  var client = http.Client();
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
  final _box = GetStorage(); 

  void initState() {
    _box.read(ApiUrl.studentId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Course"),
      ),
      body: FutureBuilder(
                    future: fetchstudentCourseModel(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: std_course_list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder:((context) => StudentAttendaceShow())));
                              },
                              title: Text(
                                  std_course_list[index].course.toString()),
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
    );
  }
}