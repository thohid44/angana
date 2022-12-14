import 'dart:convert';

import 'package:angana/model/GetCourseStudentResponse.dart';
import 'package:angana/model/student_details_model.dart';
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
      body: FutureBuilder<GetCourseStudentResponse>(
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
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>TeacherTotalClsHelpPrevious()));
                        },
                        child: Text(
                          snapshot.data!.data![index].name.toString(),
                          style: TextStyle(
                              fontSize: 12.sp,fontWeight: FontWeight.bold ),
                        ),
                      ),
                      // Text(
                      //   snapshot.data!.data![index].roll.toString(),
                      //   style: TextStyle(
                      //       fontSize: 10.sp, fontWeight: FontWeight.w600),
                      // ),
                     
                      GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   if (rollList.contains(attend[index]['id'])) {
                          //     rollList.remove(attend[index]['id']);
                          //     print(rollList.remove(attend[index]['id']));
                          //     print(rollList);
                          //   } else {
                          //     rollList.add(attend[index]['id']);
                          //     print(rollList.length);
                          //     print(rollList);
                          //   }
                          // });
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
    );
  }

  List rollList = [];
  
}
