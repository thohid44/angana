import 'dart:convert';


import 'package:angana/model/student_course_model.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:angana/views/todays_attends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  String? selector;

   
   
Future<TeacherRunningCourseResponse>courseFetch() async {
    var res = await http.get(Uri.parse("http://puc.ac.bd:8098/api/Teacher/RunningCourses?deptId=1&userId=4"));

    var jsonData = jsonDecode(res.body.toString());
   
     if(res.statusCode ==200){
      return TeacherRunningCourseResponse.fromJson(jsonData);
     }else{
  return TeacherRunningCourseResponse.fromJson(jsonData);
     }
     
  }

  void initState() {
    courseFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List student_course = [StudentCourseResponse(course: "Physics")];
    return Scaffold(
      appBar: AppBar(title: Text("Teacher Section"), 
      centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<TeacherRunningCourseResponse>(
                future: courseFetch (),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  onTap: (() {
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>TodaysAttends(coureId: snapshot.data!.data![index].id.toString(),)));
                                  }),
                                  title: Text(snapshot.data!.data![index].coursename.toString()),
                                  subtitle: Text(snapshot.data!.data![index].id.toString()),
                                  
                                ),
                                
                               
                              ],
                            ),
                          );
                        });
                  }else {
                    return Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  // Widget runningCourse(){
  //   return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             height: 45.h,
  //             padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
  //             decoration: BoxDecoration(
  //                 border: Border.all(
  //                   width: 1.w,
  //                 ),
  //                 borderRadius: BorderRadius.circular(13.r)),
  //             child: DropdownButton(
  //               onChanged: (value) {
  //                 setState(() {
  //                   selector = value.toString();
  //                 });

  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => TodaysAttends()));
  //               },
  //               value: selector,

  //               // Hide the default underline
  //               underline: Container(),
  //               hint: Center(
  //                   child: Text(
  //                 'Select Course',
  //                 style: TextStyle(
  //                     fontFamily: 'Manjari',
  //                     fontWeight: FontWeight.w700,
  //                     fontSize: 14.sp),
  //               )),
  //               icon: Icon(
  //                 Icons.arrow_downward,
  //                 color: Colors.black,
  //                 size: 20.h,
  //               ),
  //               isExpanded: true,

  //               // The list of options
  //               items: teaRuningCourse
  //                   .map((map) => DropdownMenuItem(
  //                         child: Container(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             map.toString(),
  //                             style: TextStyle(
  //                                 fontSize: 14.sp, fontWeight: FontWeight.w700),
  //                           ),
  //                         ),
  //                         value: map,
  //                       ))
  //                   .toList(),

  //               // Customize the selected item
  //               selectedItemBuilder: (BuildContext context) => course
  //                   .map((map) => Center(
  //                         child: Text(
  //                           map.toString(),
  //                           style: TextStyle(
  //                               fontFamily: 'Manjari',
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 12.sp),
  //                         ),
  //                       ))
  //                   .toList(),
  //             ),
  //           ),
  //         ],
  //       );
  }


