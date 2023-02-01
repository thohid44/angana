import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/complete_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TeacherCompleteCourse extends StatefulWidget {
  const TeacherCompleteCourse({super.key});

  @override
  State<TeacherCompleteCourse> createState() => _TeacherCompleteCourseState();
}

class _TeacherCompleteCourseState extends State<TeacherCompleteCourse> {
  Future<CompletedCourseModel> completedCourseFetch() async {
    var res = await http
        .get(Uri.parse("http://puc.ac.bd:8098/api/Session/Completed?deptId=$tDeptId"));

    var jsonData = jsonDecode(res.body.toString());
    print(jsonData);
    if (res.statusCode == 200) {
      return CompletedCourseModel.fromJson(jsonData);
    } else {
      return CompletedCourseModel.fromJson(jsonData);
    }
  }

  final _box = GetStorage();
  var tDeptId; 
  void initState() {
    tDeptId = _box.read(ApiUrl.TdeptId);
    completedCourseFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Course"),
      ),
      body: FutureBuilder<CompletedCourseModel>(
        future: completedCourseFetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: (() {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => TodaysAttends(
                            //               coureId: snapshot
                            //                   .data!.data![index].id
                            //                   .toString(),
                            //             )));
                          }),
                          title: Text(snapshot.data!.data![index].sessionname
                              .toString(), style: TextStyle( fontSize: 16.sp, fontWeight: FontWeight.bold)),
                          subtitle:
                              Text(snapshot.data!.data![index].status.toString(), 
                              style: TextStyle(color: Colors.green, fontSize: 16.sp, fontWeight: FontWeight.bold),
                              ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: Text('Loading'));
          }
        },
      ),
    );
  }
}
