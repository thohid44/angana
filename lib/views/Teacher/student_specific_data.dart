import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/StdClassDetailsModel.dart';
import 'package:angana/model/get_student_class_short_details_model.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
class StudentSpecificData extends StatefulWidget {
  const StudentSpecificData({super.key});

  @override
  State<StudentSpecificData> createState() => _StudentSpecificDataState();
}

class _StudentSpecificDataState extends State<StudentSpecificData> {

  final TextEditingController _stdId = TextEditingController(); 
    final _box = GetStorage(); 
   var departId; 
   var teacherId; 
   var teacherDeptId; 
   var stdId; 
  void initState() {
     departId =      _box.read(ApiUrl.dId);
     teacherDeptId = _box.read(ApiUrl.TdeptId);
     print(teacherDeptId);

     teacherId = _box.read(ApiUrl.teacherId);
     print(teacherId);
    super.initState();
  }
  bool searchFalse = false; 
  Future<GetStudentClassShortDetails> getStdClsShortDetails() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/getStudentClassShortDetails?studentId=${stdId}&sessionCourseId=6818&deptId=1"));

    var jsonData = jsonDecode(res.body);
    print(jsonData);
    if (res.statusCode == 200) {
      return GetStudentClassShortDetails.fromJson(jsonData);
    } else {
      return GetStudentClassShortDetails.fromJson(jsonData);
    }
  }


Future<TeacherRunningCourseResponse> courseFetch() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/RunningCourses?deptId=$departId&userId=$teacherId"));

    var jsonData = jsonDecode(res.body.toString());
 
    if (res.statusCode == 200) {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    } else {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    }
  }
  var course;
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
         Expanded(
           child: Container(
                         margin: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 40.h,
                          alignment: Alignment.center,
                       
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: Colors.grey)),
                          child: FutureBuilder<TeacherRunningCourseResponse>(future: courseFetch(),
                          builder: ((context, snapshot) {
                            if(snapshot.hasData){
                              var data = snapshot.data!; 
                              return DropdownButton(
                                hint: Text("Select Course ", style: TextStyle(fontSize:18.sp),),
                                underline: SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                               value: course,
                                items: snapshot.data!.data!.map((e) =>DropdownMenuItem(
                                value:e.coursecode, 
                                child:Text("${e.coursename}",style: TextStyle(fontSize:14.sp)),
                                
                                )).toList(),
                              
                               onChanged:(value){
                                setState(() {
                                  course = value.toString();
                                  print(course);
                                });
                               });
                            }
                            return Center(child: CircularProgressIndicator(),);
                          }),
                          
                          )),
         ),
          SizedBox(
            height: 20.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              height: 45.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Colors.grey)),
              child: TextFormField(
                controller: _stdId, 
                decoration: InputDecoration(
                  hintText: "Enter Student Id", 
                  
                ),
              )),
               SizedBox(height: 20.h),
               InkWell(
                onTap: (){
                  print(_stdId.text);
                 
                  setState(() {
                    stdId = _stdId.text.toString();
                    searchFalse=true;
                     getStdClsShortDetails();
                  });
             
                },
                 child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 100.w),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green
                  ),
                  child: Text("Search", style: TextStyle(fontSize: 18.sp,color: Colors.white, fontWeight: FontWeight.bold),),
                 ),
               ), 
                  SizedBox(height: 30.h,),
          Container(
            height: 300.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.centerLeft,
            child: searchFalse==true?FutureBuilder<GetStudentClassShortDetails>(
              future: getStdClsShortDetails(),
              builder:((context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: ((context, index) {
                  return  Column(
                    children: [
                       Container(
                    padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                  child: Text(
                    "Total Present: ${snapshot.data.data[index].presentClass.toString()}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ), 
                 Container(
                    padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                  child: Text(
                    "Total Absent: ${snapshot.data.data[index].absentClass.toString()}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                 Container(
                    padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                  child: Text(
                    "Total Class: ${snapshot.data.data[index].totalClass.toString()}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ), 
                 Container(
                    padding: EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                  child: Text(
                    "Percentage: ${snapshot.data.data[index].percentage.toString()}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                )
                    ],
                  );
                }));
              }
              return Center(child: Text("No Data fetch "),);
            })) :Center(
              child: Text("Search by student Id and Course"),
            ),
          )
        ],
      ),
    );
  }
}
