import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_session_course_response.dart';

import 'package:angana/views/Student/student_specific_attendance_show.dart';
import 'package:angana/views/student_model/student_get_session_model.dart';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class StudentShowCourse extends StatefulWidget {
  const StudentShowCourse({super.key});

  @override
  State<StudentShowCourse> createState() => _StudentShowCourseState();
}

class _StudentShowCourseState extends State<StudentShowCourse> {
  var selector;
  String? eaxmValue;
  String? session; 

  List<StudentSessionCourseResponse> std_course_list = [];

  List<StudentGetSessionModel>? std_session_list;

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

  Future<List<StudentGetSessionModel>?> getStudentSessionModel() async {
    
  var client = http.Client();
    var response = await client.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Student/GetSession?user=$stdId&programID=$departId"));
    var res = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      for (var item in res) {
        StudentGetSessionModel list =
            StudentGetSessionModel.fromJson(item);
        std_session_list!.add(list);
      }
      return std_session_list;
    }
    return std_session_list;
  }
  
  final _box = GetStorage(); 
  
var stdId; 
var departId;
  void initState() {
     stdId = _box.read(ApiUrl.studentId);
     departId =      _box.read(ApiUrl.dId);
    
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        title: Text("Student Course"),
      ),
      body:  FutureBuilder<List<StudentSessionCourseResponse>>(future: fetchstudentCourseModel(),
                        builder: ((context, snapshot) {
                          if(snapshot.hasData){
                            var data = snapshot.data!; 
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder:((context, index) {
                             
                              return Card(

                                child: ListTile(
                                
                                title: Text(data[index].course.toString()),
                                onTap: (){
                                  print(data[index].id);
                                   Navigator.push(context, MaterialPageRoute(builder:(context)=>StudentAttendaceShow(
                                    courseSessionId: data[index].id,
                                   )));
                                },
                                                          ),
                              ); 
                            }));
                          }
                          return Center(child: CircularProgressIndicator(),);
                        }),
                        
                        )
    );
  }
}