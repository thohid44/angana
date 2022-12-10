import 'dart:convert';

import 'package:angana/model/student_course_model.dart';
import 'package:angana/views/student_show_course.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {

void initState(){
  fetchstudentCourseModel();
  super.initState(); 
}
var client = http.Client();
var selector;
List<StudentCourseResponse> std_course_list=[];

 Future<List<StudentCourseResponse>> fetchstudentCourseModel() async{
  
  var response = await client.get(Uri.parse("http://puc.ac.bd:8098/api/Student/SessionCourse?user=1703310201452&sessionID=170&programID=1")); 
   var  res = jsonDecode(response.body); 
   for (var item in res) {
     StudentCourseResponse  list = StudentCourseResponse.fromJson(item); 
   }


return []; 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Home"),),
      body: Column(
        children: [ 
          SizedBox(height: 30.h,),
          Container(
            padding: EdgeInsets.only(left: 15.w, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text("Student Name: Angana Barua",
            style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.w600),),
          ), 
          Container(
                padding: EdgeInsets.only(left: 15.w),
                 alignment: Alignment.centerLeft,
            child: Text("Student Roll: 1234565", 
            style: TextStyle(fontSize: 17.sp, color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ), 

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
                  if (selector == 'Physics') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentShowCourse()));
                  }
                },
                value: selector,

                // Hide the default underline
                underline: Container(),
                hint: Center(
                    child: Text(
                  'Select Semester',
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
                items: std_course_list
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
                selectedItemBuilder: (BuildContext context) => std_course_list
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
      )
    );
  }

  
}
