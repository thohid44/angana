import 'dart:convert';

import 'package:angana/model/student_course_model.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:angana/views/todays_attends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  String? selector;

  List<StudentCourseModel> student_course = [
    StudentCourseModel(course: "Physics")
  ];
  courseFetch() async {
    var res = await DefaultAssetBundle.of(context)
        .loadString("assets/student_course_model.json");

    final jsonData = jsonDecode(res.toString());
    print(jsonData);
    for (var i in jsonData) {
      StudentCourseModel data = StudentCourseModel.fromJson(i);
      print(data.course);
    }

    return student_course;
  }

  void initState() {
    courseFetch();
    print(student_course.first.examtype);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teacher Section")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45.h,
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(13.r)),
              child: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    selector = value.toString();
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TodaysAttends()));
                },
                value: selector,

                // Hide the default underline
                underline: Container(),
                hint: Center(
                    child: Text(
                  'Select Course',
                  style: TextStyle(
                      fontFamily: 'Manjari',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp),
                )),
                icon: Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                  size: 20.h,
                ),
                isExpanded: true,

                // The list of options
                items: student_course
                    .map((map) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              map.course.toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          value: map,
                        ))
                    .toList(),

                // Customize the selected item
                selectedItemBuilder: (BuildContext context) => student_course
                    .map((map) => Center(
                          child: Text(
                            map.toString(),
                            style: TextStyle(
                                fontFamily: 'Manjari',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
