import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_attend_short_report.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentAttendShortReport extends StatefulWidget {
  StudentAttendShortReport({super.key, String? sessionCourseId});

  @override
  State<StudentAttendShortReport> createState() =>
      _StudentAttendShortReportState();
}

class _StudentAttendShortReportState extends State<StudentAttendShortReport> {
  var deptId;
  var teacherId;
  String? entryBy;
  String selectedValue = 'Select Course';
  var course;
  final _box = GetStorage();
  Future<StudentAttendShortReportModel> attendShortReport() async {
    var response = await http.get(
      Uri.parse(
          "http://puc.ac.bd:8098/api/StudentAttendance/shortReport?sessionCourseId=$course&date=$date&deptId=$deptId"),
    );

    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return StudentAttendShortReportModel.fromJson(res);
    }
    return StudentAttendShortReportModel.fromJson(res);
  }

  Future<TeacherRunningCourseResponse> courseFetch() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/RunningCourses?deptId=$deptId&userId=$teacherId"));

    var jsonData = jsonDecode(res.body.toString());

    if (res.statusCode == 200) {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    } else {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    }
  }
 bool status=false;
  String date='';
  final TextEditingController selectDate = TextEditingController();
  void initState() {
    deptId = _box.read(ApiUrl.TdeptId);
    entryBy = _box.read(ApiUrl.userName);
    teacherId = _box.read(ApiUrl.teacherId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Get Short Details of specific Day",
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Container(
              height: 40.h,
              margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
              decoration: BoxDecoration(border: Border.all(width: 1.w)),
              child: TextFormField(
                controller: selectDate,
                decoration: InputDecoration(hintText: "Month-Day-Year"),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
                              date = selectDate.text;
                              
                              status = true;
                              attendShortReport();
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
              child:status==true? FutureBuilder<StudentAttendShortReportModel>(
                  future: attendShortReport(),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          height: 300.h,
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: ((context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "Present Student: ${snapshot.data.data[index].presentStudent.toString()}"),
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "Absent Student: ${snapshot.data.data[index].absentStudent.toString()}"),
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "Total Student: ${snapshot.data.data[index].totalStudent.toString()}"),
                                    ),
                                  ],
                                );
                              })));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }), 
                  ):Center(child:Text("Select Date and Course")),
            )
          ],
        ));
  }
}
