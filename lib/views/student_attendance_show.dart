import 'dart:convert';

import 'package:angana/views/student_model/student_attend_show_model.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class StudentAttendaceShow extends StatefulWidget {
  const StudentAttendaceShow({super.key});

  @override
  State<StudentAttendaceShow> createState() => _StudentAttendaceShowState();
}

class _StudentAttendaceShowState extends State<StudentAttendaceShow> {

Future<StudentAttendShowModel> fetchStudentAttend() async {
    
  var client = http.Client();
    var response = await client.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/shortReport?sessionCourseId=6818&date=10-19-2022&deptId=1"));
    var res = jsonDecode(response.body);
       
       print(res); 
       if(response.statusCode==200){
        return StudentAttendShowModel.fromJson(res);
       }

       return StudentAttendShowModel.fromJson(res);
  }

   void initState(){
   
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Attendance Report"),
      ),

      body: FutureBuilder<StudentAttendShowModel>(
        future: fetchStudentAttend(),
        builder: ((context,AsyncSnapshot snapshot) {
          
        //   if(snapshot.hasData){
        //     return
        //      AspectRatio(
        //        aspectRatio: 16/9,
        //        child: DChartPie(
        //          data: snapshot.data.data!.map((e) {
        //           return Container(child: Text(e),);
        //          }).toList(),


        //          fillColor: (pieData, index) => Colors.purple,
        //      ),
             
          
        // );
        //   }
          return Center(child: CircularProgressIndicator(),);
          
        }),
      )
    );
  }

  

}