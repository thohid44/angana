import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/totalclass_held.dart';
import 'package:angana/views/widgets/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TeacherTotalClsHelpPrevious extends StatefulWidget {
  const TeacherTotalClsHelpPrevious({super.key});

  @override
  State<TeacherTotalClsHelpPrevious> createState() =>
      _TeacherTotalClsHelpPreviousState();
}

class _TeacherTotalClsHelpPreviousState
    extends State<TeacherTotalClsHelpPrevious> {
  Future<TotalClassHeld> getTotalClass() async {
    TotalClassHeld? held;
    var response = await http.get(Uri.parse("http://puc.ac.bd:8098/api/StudentAttendance/getTotalClassHeld?sessionCourseId=6818&deptId=1"));
     var res = jsonDecode(response.body); 
     print(res);
    if(response.statusCode==200){
         return TotalClassHeld.fromJson(res);
    }
    return TotalClassHeld.fromJson(res);
  }

final _box = GetStorage();
var tDeptId;
 void initState(){
  tDeptId= _box.read(ApiUrl.TdeptId); 
  super.initState();
 
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total Class Help Previous")),
      body: ListView(
       
        children: [

            Container(
              height: 400.h,
              child: Expanded(
                
                child: FutureBuilder<TotalClassHeld>(
                  future: getTotalClass(),
                  builder:((context,AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.data.length,
                itemBuilder:((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.amberAccent,
                    child: Column(
                      children: [
                         Container(
                      padding: EdgeInsets.only(
                        left: 25.sp,top: 5, bottom: 5
                      ),
                      alignment: Alignment.centerLeft,
                      child:Text("Session Course ID : ${snapshot.data.data[index].tblSessioncourseId}",style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold
                      ),)
                    ),
                        Container(
                      padding: EdgeInsets.only(
                        left: 25.sp,top: 5, bottom: 5
                      ),
                      alignment: Alignment.centerLeft,
                      child:Text("Day : ${snapshot.data.data[index].day}",style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold
                      ),)
                    ),
                     Container(
                      padding: EdgeInsets.only(
                        left: 25.sp,top: 5, bottom: 5
                      ),
                      alignment: Alignment.centerLeft,
                      child:Text("Date : ${snapshot.data.data[index].date}",style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold
                      ),)
                    ),
                        Container(
                      padding: EdgeInsets.only(
                        left: 25.sp,top: 5, bottom: 5
                      ),
                      alignment: Alignment.centerLeft,
                      child:Text("Class Start : ${snapshot.data.data[index].classStart}",style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold
                      ),)
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 25.sp,top: 5, bottom: 5
                      ),
                      alignment: Alignment.centerLeft,
                      child:Text("Class End : ${snapshot.data.data[index].classEnd}",style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold
                      ),)
                    ),
                      
                      ],
                    ),
                  ),
                );
              }));
                  }
              
                  return Center(child: CircularProgressIndicator(),);
                })),
              ),
            )
        ],
      ),
    );
  }
}
