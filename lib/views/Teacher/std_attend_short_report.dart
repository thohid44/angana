import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_attend_short_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class StudentAttendShortReport extends StatefulWidget {


   StudentAttendShortReport({super.key, String? sessionCourseId});

  @override
  State<StudentAttendShortReport> createState() => _StudentAttendShortReportState();
}

class _StudentAttendShortReportState extends State<StudentAttendShortReport> {
   
 
    var deptId; 
   String? entryBy;
   final _box = GetStorage();
 Future<StudentAttendShortReportModel> attendShortReport() async{
    var response = await http.get(Uri.parse("http://puc.ac.bd:8098/api/StudentAttendance/shortReport?sessionCourseId=6818&date=10-19-2022&deptId=$deptId"), 
  
    );

    var res = jsonDecode(response.body);
    if(response.statusCode==200){
     return StudentAttendShortReportModel.fromJson(res);
    }
      return StudentAttendShortReportModel.fromJson(res);
   }
   void initState(){
    deptId = _box.read(ApiUrl.TdeptId);
    entryBy = _box.read(ApiUrl.userName);
    super.initState();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance Short Report"),),
      body: Column(
        children: [

     SizedBox(height: 50.h,), 
          Container(
            child: FutureBuilder<StudentAttendShortReportModel>(
              future: attendShortReport(),
              builder:((context,AsyncSnapshot snapshot) {
              if(snapshot.hasData){
             return Container(
              height: 300.h,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder:((context, index) {
                  return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                    
                  SizedBox(height: 15.h,), 
                   Container(
                        height: 50.h,
                      child: Text("Present Student: ${snapshot.data.data[index].presentStudent.toString()}"),
                  ),

                    Container(
                        height: 50.h,
                      child: Text("Absent Student: ${snapshot.data.data[index].absentStudent.toString()}"),
                  ),
                    Container(
                        height: 50.h,
                      child: Text("Total Student: ${snapshot.data.data[index].totalStudent.toString()}"),
                  ),
                    ],
                  );
                }))
              );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            })),
          )
        ],
      )
    );
  }


   
  
}