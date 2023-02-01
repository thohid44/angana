import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/routine_model.dart';
import 'package:angana/model/student_attend_short_report.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class Routine extends StatefulWidget {
  Routine({super.key, String? sessionCourseId});

  @override
  State<Routine> createState() =>
      _RoutineState();
}

class _RoutineState extends State<Routine> {
  var deptId;
  var teacherId;
  String? entryBy;
  String selectedValue = 'Select Course';
  var course;
  final _box = GetStorage();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Select Day"), value: "Select Day"),
      const DropdownMenuItem(child: Text("Saturday"), value: "saturday"),
      const DropdownMenuItem(child: Text("Sunday"), value: "sunday"),
         const DropdownMenuItem(child: Text("Monday"), value: "monday"),
            const DropdownMenuItem(child: Text("TuesDay"), value: "tuesnday"),
                 const DropdownMenuItem(child: Text("Wednessday"), value: "wednessday"),
    ];
    return menuItems;
  }

  String selectDay = 'Select Day';
  Future<RoutineModel> getRoute() async {
    var response = await http.get(
      Uri.parse(
          "http://puc.ac.bd:8098/api/StudentAttendance/CheckClassRoutine?sessionCourseId=$course&day=saturday&deptId=$deptId"),
    );

    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return RoutineModel.fromJson(res);
    }
    return RoutineModel.fromJson(res);
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
                              getRoute();
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
              child:status==true? FutureBuilder<RoutineModel>(
                  future: getRoute(),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          height: 300.h,
                          child: ListView.builder(
                              itemCount: snapshot.data.data.length,
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
                                          "Day: ${snapshot.data.data[index].dayname.toString()}"),
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "Class Time: ${snapshot.data.data[index].classTime.toString()}"),
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "start Date: ${snapshot.data.data[index].classStart.toString()}"),
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "End Date: ${snapshot.data.data[index].classEnd.toString()}"),
                                    ),
                                    
                                    Container(
                                      height: 50.h,
                                      child: Text(
                                          "End Date: ${snapshot.data.data[index].adjClass.toString()}"),
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
