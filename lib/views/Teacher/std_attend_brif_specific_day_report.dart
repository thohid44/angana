import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/brif_report_model.dart';
import 'package:angana/model/student_attend_short_report.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentAttendBrifReport extends StatefulWidget {
  StudentAttendBrifReport({super.key, String? sessionCourseId});

  @override
  State<StudentAttendBrifReport> createState() =>
      _StudentAttendBrifReportState();
}

class _StudentAttendBrifReportState extends State<StudentAttendBrifReport> {
  var deptId;
  var teacherId;
  String? entryBy;
  String selectedValue = 'Select Course';
  var course;
  final _box = GetStorage();
  Future<BrifReportModel> attendBrifReport() async {
    var response = await http.get(
      Uri.parse(
          "http://puc.ac.bd:8098/api/StudentAttendance/brifReport?sessionCourseId=$course&date=$date&deptId=$deptId"),
    );

    var res = jsonDecode(response.body);
    print(res); 
    if (response.statusCode == 200) {
      return BrifReportModel.fromJson(res);
    }
    return BrifReportModel.fromJson(res);
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

  bool status = false;
  String date = '';
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
              height: 10.h,
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
                              attendBrifReport();
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
              child: status == true
                  ? FutureBuilder<BrifReportModel>(
                      future: attendBrifReport(),
                      builder: ((context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              height: 400.h,
                              child: ListView.builder(
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder: ((context, index) {
                                    return Card(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                                        child: Column(
                                                                       
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                           
                                            Container(
                                            padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                  "Student Name: ${snapshot.data.data[index].name.toString()}"),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                  "Roll: ${snapshot.data.data[index].roll.toString()}"),
                                            ),
                                             Container(
                                               padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                  "Status: ${snapshot.data.data[index].batchName.toString()}"),
                                            ),
                                            Container(
                                               padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                  "Status: ${snapshot.data.data[index].status.toString()}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })));
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    )
                  : Center(child: Text("Select Date and Course")),
            )
          ],
        ));
  }
}
