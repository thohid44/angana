import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/views/student_model/student_attend_show_model.dart';
import 'package:angana/views/student_model/student_specific_attendance_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentAttendaceShow extends StatefulWidget {
  var courseSessionId;
   StudentAttendaceShow({super.key , this.courseSessionId});

  @override
  State<StudentAttendaceShow> createState() => _StudentAttendaceShowState();
}

class _StudentAttendaceShowState extends State<StudentAttendaceShow> {

  final _box = GetStorage();
var stdId; 
var departId;
Future<StudentSpicificAttendanceModel> fetchStudentAttend() async {
    
  var client = http.Client();
    var response = await client.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/getStudentClassShortDetails?studentId=$stdId&sessionCourseId=6818&deptId=$departId"));
    var res = jsonDecode(response.body);
       
       print(res); 
       if(response.statusCode==200){
        return StudentSpicificAttendanceModel.fromJson(res);
       }

       return StudentSpicificAttendanceModel.fromJson(res);
  }

   void initState(){
    stdId = _box.read(ApiUrl.studentId);
     departId =      _box.read(ApiUrl.dId);
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Attendance Report"),
      ),

      body: FutureBuilder<StudentSpicificAttendanceModel>(
        future: fetchStudentAttend(),
        builder: ((context,AsyncSnapshot snapshot) {

        if(snapshot.hasData){
            return ListView.builder(
            itemCount: snapshot.data.data.length,
            itemBuilder:(context,index){
             return   Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
               children: [
                 Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text("Total Present : ${snapshot.data.data[index].presentClass.toString()}",)),
                 Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text("Total Absent : ${snapshot.data.data[index].absentClass.toString()}",)),
                 Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text("Total Class : ${snapshot.data.data[index].totalClass.toString()}",)),
               ],
             );
            
          });
        }
          
          
          return Center(child: CircularProgressIndicator(),);
          
        }),
      )
    );
  }

  

}