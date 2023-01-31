import 'dart:convert';
import 'package:angana/api_url.dart';
import 'package:angana/model/GetCourseStudentResponse.dart';
import 'package:angana/model/get_student_class_short_details_model.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentSpecificDataView extends StatefulWidget {
  String? stdId;
  String? course;
  StudentSpecificDataView(
    this.stdId,
    this.course,
  );
  @override
  State<StudentSpecificDataView> createState() =>
      _StudentSpecificDataViewState();
}

class _StudentSpecificDataViewState extends State<StudentSpecificDataView> {
  final _box = GetStorage();
  var departId;
  var teacherId;
  var teacherDeptId;

  void initState() {
    departId = _box.read(ApiUrl.dId);
    teacherDeptId = _box.read(ApiUrl.TdeptId);
    print(teacherDeptId);

    teacherId = _box.read(ApiUrl.teacherId);
    print(teacherId);
    super.initState();
  }

  bool searchFalse = false;
  Future<GetStudentClassShortDetails> getStdClsShortDetails() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/getStudentClassShortDetails?studentId=${widget.stdId}&sessionCourseId=${widget.course}&deptId=$teacherDeptId"));

    var jsonData = jsonDecode(res.body);
    print(jsonData);
    if (res.statusCode == 200) {
      return GetStudentClassShortDetails.fromJson(jsonData);
    } else {
      return GetStudentClassShortDetails.fromJson(jsonData);
    }
  }

  var course;

  @override
  Widget build(BuildContext context) {
    print("course id ${widget.course}");
    print("Student id ${widget.stdId}");
    return Scaffold(
     
      appBar: AppBar(
        title: Text(
          "Student Specific Data View",
          style: TextStyle(fontSize: 17.sp),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
              height: 300.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              alignment: Alignment.centerLeft,
              child: FutureBuilder<GetStudentClassShortDetails>(
                  future: getStdClsShortDetails(),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.data.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Total Present: ${snapshot.data.data[index].presentClass.toString()}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Total Absent: ${snapshot.data.data[index].absentClass.toString()}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Total Class: ${snapshot.data.data[index].totalClass.toString()}",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          }));
                    }
                    return Center(
                      child: Text("No Data fetch "),
                    );
                  })))
        ],
      ),
    );
  }
}
