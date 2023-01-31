import 'dart:convert';
import 'package:angana/api_url.dart';
import 'package:angana/model/GetCourseStudentResponse.dart';
import 'package:angana/model/get_student_class_short_details_model.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:angana/views/Teacher/student_specific_data_details_view.dart';
import 'package:angana/views/Teacher/student_specific_data_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentSpecificDataDetails extends StatefulWidget {
  const StudentSpecificDataDetails({super.key});

  @override
  State<StudentSpecificDataDetails> createState() => _StudentSpecificDataDetailsState();
}

class _StudentSpecificDataDetailsState extends State<StudentSpecificDataDetails> {
  final TextEditingController _stdId = TextEditingController();
  final _box = GetStorage();
  var departId;
  var teacherId;
  var teacherDeptId;
  var stdId;
  void initState() {
    departId = _box.read(ApiUrl.dId);
    teacherDeptId = _box.read(ApiUrl.TdeptId);
    print(teacherDeptId);

    teacherId = _box.read(ApiUrl.teacherId);
    print(teacherId);
    super.initState();
  }

  bool searchFalse = false;
  // Future<GetStudentClassShortDetails> getStdClsShortDetails() async {
  //   var res = await http.get(Uri.parse(
  //       "http://puc.ac.bd:8098/api/StudentAttendance/getStudentClassShortDetails?studentId=${stdId}&sessionCourseId=$course&deptId=$teacherDeptId"));

  //   var jsonData = jsonDecode(res.body);
  //   print(jsonData);
  //   if (res.statusCode == 200) {
  //     return GetStudentClassShortDetails.fromJson(jsonData);
  //   } else {
  //     return GetStudentClassShortDetails.fromJson(jsonData);
  //   }
  // }

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

  Future<GetCourseStudentResponse> studentFetchbyCourse() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/GetCourseStudent?courseId=$course&programId=1"));

    var jsonData = jsonDecode(res.body.toString());
    print(jsonData);
    if (res.statusCode == 200) {
      return GetCourseStudentResponse.fromJson(jsonData);
    } else {
      return GetCourseStudentResponse.fromJson(jsonData);
    }
  }

  var course;
  String selectedValue = 'Select Course';
  String selectedId = 'Student Id';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Student Specific Data  By Course",
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
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

                              studentFetchbyCourse();
                              searchFalse = true;
                              print(course);
                            });
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                )),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 500.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            alignment: Alignment.centerLeft,
            child: searchFalse == true
                ? FutureBuilder<GetCourseStudentResponse>(
                    future: studentFetchbyCourse(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: ((BuildContext context, index) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 10.w, right: 10.w),
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              height: 40.h,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.data![index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentSpecificDataDetailsView(
                                                        snapshot.data!
                                                            .data![index].id
                                                            .toString(),
                                                        course)));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40.h,
                                        width: 60.w,
                                        color: Colors.purple,
                                        child: Text(
                                          "Details",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }),
                        );
                      }

                      return Center(
                        child: Text("Loading...."),
                      );
                    }),
                  )
                : Center(
                    child: Text("Search by  Course"),
                  ),
          )
        ],
      ),
    );
  }
}
