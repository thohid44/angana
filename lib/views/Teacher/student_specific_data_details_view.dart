import 'dart:convert';
import 'package:angana/api_url.dart';
import 'package:angana/model/GetCourseStudentResponse.dart';
import 'package:angana/model/get_student_class_short_details_model.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:angana/views/student_model/std_specific_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class StudentSpecificDataDetailsView extends StatefulWidget {
  String? stdId;
  String? course;
  StudentSpecificDataDetailsView(
    this.stdId,
    this.course,
  );
  @override
  State<StudentSpecificDataDetailsView> createState() =>
      _StudentSpecificDataDetailsViewState();
}

class _StudentSpecificDataDetailsViewState
    extends State<StudentSpecificDataDetailsView> {
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
  Future<StudentSpecificDatailsModel> getStdClsShortDetails() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/StudentAttendance/getStudentClassDetails?studentId=${widget.stdId}&sessionCourseId=${widget.course}&deptId=$teacherDeptId"));

    var jsonData = jsonDecode(res.body);
    print(jsonData);
    if (res.statusCode == 200) {
      return StudentSpecificDatailsModel.fromJson(jsonData);
    } else {
      return StudentSpecificDatailsModel.fromJson(jsonData);
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
        body: FutureBuilder<StudentSpecificDatailsModel>(
            future: getStdClsShortDetails(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Date: ${snapshot.data.data[index].date.toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Day: ${snapshot.data.data[index].day.toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Class Start: ${snapshot.data.data[index].classStart.toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Class End: ${snapshot.data.data[index].classEnd.toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Adjustment Class: ${snapshot.data.data[index].adjustmentClass.toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Status: ${snapshot.data.data[index].status.toString()}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
              }
              return Center(
                child: Text("No Data fetch "),
              );
            })));
  }
}
