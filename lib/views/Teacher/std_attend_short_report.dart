import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/model/student_attend_short_report.dart';
import 'package:angana/model/teacher_running_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class StudentAttendShortReport extends StatefulWidget {


   StudentAttendShortReport({super.key, String? sessionCourseId});

  @override
  State<StudentAttendShortReport> createState() => _StudentAttendShortReportState();
}

class _StudentAttendShortReportState extends State<StudentAttendShortReport> {
    var course;
  String selectedValue = 'Select Course';
 
    var deptId; 

   final _box = GetStorage();
 Future<StudentAttendShortReportModel> attendShortReport() async{
    var response = await http.get(Uri.parse("http://puc.ac.bd:8098/api/StudentAttendance/shortReport?sessionCourseId=6818&date=$date&deptId=$deptId"), 
  
    );

    var res = jsonDecode(response.body);
    if(response.statusCode==200){
     return StudentAttendShortReportModel.fromJson(res);
    }
      return StudentAttendShortReportModel.fromJson(res);
   }
   bool isData = false;
    var teacherId; 
   void initState(){
    deptId = _box.read(ApiUrl.TdeptId);
     teacherId = _box.read(ApiUrl.teacherId);
     courseFetch();
    super.initState();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance Short Report"),),
      body: Column(
        children: [
               SizedBox(height: 50.h,), 
  Container(
      width: 200,
           
              height: 45.h,
               child: _buildDatePicker()
             ),
 SizedBox(height: 15.h,), 
 Container(
                         margin: EdgeInsets.symmetric(horizontal: 15.w),
                          height: 40.h,
                          alignment: Alignment.center,
                       
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.w, color: Colors.grey)),
                          child: FutureBuilder<TeacherRunningCourseResponse>(future: courseFetch(),
                          builder: ((context, snapshot) {
                            if(snapshot.hasData){
                              var data = snapshot.data!; 
                              return DropdownButton(
                                hint: Text("Select Course ", style: TextStyle(fontSize:18.sp),),
                                underline: SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                               value: course,
                                items: snapshot.data!.data!.map((e) =>DropdownMenuItem(
                                value:e.coursecode, 
                                child:Text("${e.coursename}",style: TextStyle(fontSize:14.sp)),
                                
                                )).toList(),
                              
                               onChanged:(value){
                                setState(() {
                                  course = value.toString();
                                  print(course);
                                });
                               });
                            }
                            return Center(child: CircularProgressIndicator(),);
                          }),
                          
                          )),
         


     SizedBox(height: 50.h,), 
       isData == true?     Container(
            child: FutureBuilder<StudentAttendShortReportModel>(
              future: attendShortReport(),
              builder:((context,AsyncSnapshot snapshot) {
              if(snapshot.hasData){
             return Container(
              height: 300.h,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder:((context, index) {
                  return Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                    
                  SizedBox(height: 15.h,), 
                   Container(
                        height: 50.h,
                      child: Text("Present Student: ${snapshot.data.data[index].presentStudent.toString()}"),
                  ),

                    Container(
                        height: 50.h,
                      child: Text("Absent Student: ${snapshot.data.data[index].absentStudent.toString()}"),
                  ),
                    Container(
                        height: 50.h,
                      child: Text("Total Student: ${snapshot.data.data[index].totalStudent.toString()}"),
                  ),
                    ],
                  );
                }))
              );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            })),
          ) :Center(child: Text("Please select Date and session Id"),)
        ],
      )
    );
  }
   final TextEditingController dateController = TextEditingController(); 
 DateTime selectedDate = DateTime.now(); 
  late String date; 
  late String weekDay; 
  Widget _buildDatePicker(){
    
    return TextFormField(
    controller: dateController,
    readOnly: true,
    textAlign: TextAlign.center,
    decoration: const InputDecoration(
      contentPadding: EdgeInsets.all(8.0), 
      suffixIcon: Icon(Icons.date_range, color: Colors.black,), 
      hintText: "MM-DD-YYYY", 
      hintMaxLines: 1, 
      hintStyle: TextStyle(fontSize: 15.0), 
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
      ), 
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey)
      ), 

      
    ),
    onTap:() async{
        final pickedDate = await selectDate(
        context:context, 
        initialDate:selectedDate,
        allowedDays:_allowedDays 
         );
      if(pickedDate != null && pickedDate !=selectedDate){
setState(() {
  selectedDate = pickedDate; 
  dateController.text = DateFormat('MM-dd-yyyy').format(selectedDate); 
  print("thohid ${dateController.text}");
});
      }
      }
    );
  }
    bool _allowedDays(DateTime day) {
    if ((day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }
  selectDate({
 required BuildContext context,
  required DateTime initialDate,
  required allowedDays
}) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2010),
    lastDate: DateTime(2025),
    selectableDayPredicate: allowedDays,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
           
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return selected;
}
   
   Future<TeacherRunningCourseResponse> courseFetch() async {
    var res = await http.get(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/RunningCourses?deptId=$deptId&userId=$teacherId"));

    var jsonData = jsonDecode(res.body.toString());
 
    if (res.statusCode == 200) {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    } else {
      return TeacherRunningCourseResponse.fromJson(jsonData);
    }
  }
  
}