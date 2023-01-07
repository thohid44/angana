import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_session_course_response.dart';
import 'package:angana/model/student_session_model.dart';
import 'package:angana/views/Student/student_specific_attendance_show.dart';
import 'package:angana/views/student_model/student_get_session_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      List<StudentSessionCourseResponse> items = [];
      var jsonData = json.decode(response.body);
      for (var element in jsonData) {
        items.add(element["ClassName"]);
      }
      return items;
    } 
    
      return [];


    //   for (var item in res) {
    //     StudentSessionCourseResponse list =
    //         StudentSessionCourseResponse.fromJson(item);
    //     std_course_list.add(list);
    //   }
    //   return std_course_list;
    // }
    // return std_course_list;
  }

  Future<List<StudentGetSessionModel>?> getStudentSessionModel() async {
    
  var client = http.Client();
    var response = await client.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Student/GetSession?user=1703310201452&programID=1"));
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

  void initState() {
    _box.read(ApiUrl.studentId);
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Student Course"),
      ),
      body:  Column(
        children: [ 
          SizedBox(height: 30.h,),
        

              Container(
                       
                        height: 40.h,
                         margin: EdgeInsets.symmetric(horizontal: 10.w),
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.grey)),
                        child: FutureBuilder<List<StudentSessionCourseResponse>>(future: fetchstudentCourseModel(),
                        builder: ((context, snapshot) {
                          if(snapshot.hasData){
                            var data = snapshot.data!; 
                            return DropdownButton(
                              hint: Text("Select Exam "),
                              underline: SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down),
                             value: eaxmValue,
                              items: std_course_list.map((e) =>DropdownMenuItem(
                                onTap: (){
                     //  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentShowCourse()));
                                },
                              value:e.id.toString(), 
                              child:Text("${e.course.toString()}",style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold
                              ),),
                              
                              )).toList(),
                            
                             onChanged:(value){
                             
                                setState(() {
                                eaxmValue = value.toString();
                            
                                print(eaxmValue);
                             
                               
                              });
                               
                             });
                          }
                          return Center(child: CircularProgressIndicator(),);
                        }),
                        
                        )),
                        SizedBox(height: 20.h,), 

                            Container(
                       
                        height: 40.h,
                         margin: EdgeInsets.symmetric(horizontal: 10.w),
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.w, color: Colors.grey)),
                        child: FutureBuilder<List<StudentGetSessionModel>?>(future: getStudentSessionModel(),
                        builder: ((context, snapshot) {
                          if(snapshot.hasData){
                            var data = snapshot.data!; 
                            return DropdownButton(
                              hint: Text("Select Session "),
                              underline: SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down),
                             value: session,
                              items: std_session_list!.map((e) =>DropdownMenuItem(
                                onTap: (){
                     //  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentShowCourse()));
                                },
                              value:e.id, 
                              child:Text("${e.name.toString()}",style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold
                              ),),
                              
                              )).toList(),
                            
                             onChanged:(value){
                             
                                setState(() {
                                session = value.toString();
                            
                                print(eaxmValue);
                             
                               
                              });
                               
                             });
                          }
                          return Center(child: CircularProgressIndicator(),);
                        }),
                        
                        )),
        ],
      )
    );
  }
}