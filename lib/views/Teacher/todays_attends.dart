import 'dart:convert';

import 'package:angana/model/GetCourseStudentResponse.dart';
import 'package:angana/model/student_details_model.dart';
import 'package:angana/views/Teacher/teacher_adjustment_cls.dart';
import 'package:angana/views/Teacher/teacher_total_cls_held_previous.dart';
import 'package:angana/views/Teacher/teacherHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class TodaysAttends extends StatefulWidget {
  String? coureId;

  TodaysAttends({Key? key, this.coureId}) : super(key: key);

  @override
  State<TodaysAttends> createState() => _TodaysAttendsState();
}

class _TodaysAttendsState extends State<TodaysAttends> {
  var color;
  var data;
  var result;

  Future<GetCourseStudentResponse> studentFetchbyCourse() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/GetCourseStudent?courseId=${widget.coureId}&programId=1"));

    var jsonData = jsonDecode(res.body.toString());
    print(jsonData);
    if (res.statusCode == 200) {
      return GetCourseStudentResponse.fromJson(jsonData);
    } else {
      return GetCourseStudentResponse.fromJson(jsonData);
    }
  }

  void initState() {
    studentFetchbyCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todays Attends"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          FutureBuilder<GetCourseStudentResponse>(
            future: studentFetchbyCourse(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: ((BuildContext context, index) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 25.w, right: 25.w),
                      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                      height: 40.h,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherTotalClsHelpPrevious()));
                            },
                            child: Text(
                              snapshot.data!.data![index].name.toString(),
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            snapshot.data!.data![index].roll.toString(),
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (attend.contains(snapshot.data!.data![index].roll.toString())) {
                                  attend.remove(snapshot.data!.data![index].roll.toString());
                                  print(attend.remove(snapshot.data!.data![index].roll.toString()));
                                  print(attend);
                                } else {
                                  attend.add(attend[index]['id']);
                                  print(attend.length);
                                  print(attend);
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w),
                              alignment: Alignment.center,
                              // color: rollList.contains(attend[index]['id'])
                              //     ? Colors.red
                              //     : Colors.green,
                              width: 50.w,
                              height: 50,
                              child: Text(
                                "Present",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
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
          ),
          SizedBox(
            height: 15.h,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TeacherAjustmentClass(
                          sessionCourseId: widget.coureId)));
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40.w),
              height: 50.h,
              width: 100.w,
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                "Set Adjustment Class",
                style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  
  List attend = [];
}
