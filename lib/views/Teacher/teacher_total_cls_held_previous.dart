import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/teacher_running_course_model.dart';
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
    var response = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/getTotalClassHeld?sessionCourseId=$course&deptId=$tDeptId"));
    var res = jsonDecode(response.body);
    print(res);
    if (response.statusCode == 200) {
      return TotalClassHeld.fromJson(res);
    }
    return TotalClassHeld.fromJson(res);
  }

  Future<TeacherRunningCourseResponse> courseFetch() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/RunningCourses?deptId=$tDeptId&userId=$teacherId"));

    var jsonData = jsonDecode(res.body.toString());

    if (res.statusCode == 200) {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    } else {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    }
  }

  bool couseSelect = false;
  var course;
  final _box = GetStorage();
  var teacherId;
  var tDeptId;
  void initState() {
    courseFetch();
    tDeptId = _box.read(ApiUrl.TdeptId);
    teacherId = _box.read(ApiUrl.teacherId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total Class Help Previous")),
      body: ListView(
        children: [
          SizedBox(height: 20,), 
          Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              height: 40.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Colors.grey)),
              child: FutureBuilder<TeacherRunningCourseResponse>(
                future: courseFetch(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return DropdownButton(
                        hint: Text(
                          "Select Course ",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        underline: SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        value: course,
                        items: snapshot.data!.data!
                            .map((e) => DropdownMenuItem(
                                  value: e.id.toString(),
                                  child: Text("${e.coursename}",
                                      style: TextStyle(fontSize: 14.sp)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            course = value.toString();
                            print(course);
                            couseSelect = true;
                            getTotalClass();
                          });
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              )),
          SizedBox(
            height: 50.h,
          ),
          Container(
            height: 600.h,
            child: Expanded(
                child: couseSelect == true
                    ? FutureBuilder<TotalClassHeld>(
                        future: getTotalClass(),
                        builder: ((context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data.data.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shadowColor: Colors.amberAccent,
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 25.sp,
                                                  top: 5,
                                                  bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Session Course ID : ${snapshot.data.data[index].tblSessioncourseId}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 25.sp,
                                                  top: 5,
                                                  bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Day : ${snapshot.data.data[index].day}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 25.sp,
                                                  top: 5,
                                                  bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Date : ${snapshot.data.data[index].date}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 25.sp,
                                                  top: 5,
                                                  bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Class Start : ${snapshot.data.data[index].classStart}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 25.sp,
                                                  top: 5,
                                                  bottom: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Class End : ${snapshot.data.data[index].classEnd}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          }else{
return Center(
                            child: Text("Data not found"),
                          );
                          }

                          
                        }),
                      )
                    : Center(child: Text("Select Course"))),
          )
        ],
      ),
    );
  }
}
