import 'dart:convert';

import 'package:angana/model/teacher_running_course_model.dart';
import 'package:angana/views/Teacher/todays_attends.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherSelectCourse extends StatefulWidget {
  const TeacherSelectCourse({super.key});

  @override
  State<TeacherSelectCourse> createState() => _TeacherSelectCourseState();
}

class _TeacherSelectCourseState extends State<TeacherSelectCourse> {
  Future<TeacherRunningCourseResponse> courseFetch() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/RunningCourses?deptId=1&userId=4"));

    var jsonData = jsonDecode(res.body.toString());
    print(jsonData);
    if (res.statusCode == 200) {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    } else {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    }
  }
   void initState() {
    courseFetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Teacher Select Course"),
        ),

        body: FutureBuilder<TeacherRunningCourseResponse>(
                future: courseFetch(),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TodaysAttends(
                                                  coureId: snapshot
                                                      .data!.data![index].id
                                                      .toString(),
                                                )));
                                  }),
                                  title: Text(snapshot
                                      .data!.data![index].coursename
                                      .toString()),
                                  subtitle: Text(snapshot.data!.data![index].id
                                      .toString()),
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
      ),
    );
  }
}