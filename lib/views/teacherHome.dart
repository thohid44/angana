// import 'dart:convert';

// import 'package:angana/model/teacher_running_course_model.dart';
// import 'package:angana/views/todays_attends.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class TeacherHome extends StatefulWidget {
//   const TeacherHome({Key? key}) : super(key: key);

//   @override
//   State<TeacherHome> createState() => _TeacherHomeState();
// }

// class _TeacherHomeState extends State<TeacherHome> {
//   List<String> _serviceName = [
//     'Running',
//     'Completed',
//   ];
//   List<int> _serviceNumber = [1, 2];
//   String? selector;

//  Widget cityList(){ //widget function for city list
   
   

//       return DropdownButton(
//                 hint: Text("Select City"),
//                 isExpanded: true,
//                 items: _serviceName.map((t_Rcourse){
//                    return DropdownMenuItem(
//                         child: Text(t_Rcourse.coursename.toString()),
//                         value: t_Rcourse.coursename,
//                      );
//                 }).toList(),
//                 onChanged: (value){ 
//                   print("Selected city is $value");
//                 }
//             );
//   }
// }

// class _TeacherHomeState extends State<TeacherHome> {
//   List<String> _serviceName = [
//     'Running',
//     'Completed',
//   ];
//   List<int> _serviceNumber = [1, 2];
//   String? selector;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Teacher Section")),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 45.h,
//               padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 1.w,
//                   ),
//                   borderRadius: BorderRadius.circular(13.r)),
//               child: DropdownButton<String>(
//                 onChanged: (value) {
//                   setState(() {
//                     selector = value;
//                   });
//                   if (selector == 'Running') {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => TodaysAttends()));
//                   }
//                 },
//                 value: selector,

//                 // Hide the default underline
//                 underline: Container(),
//                 hint: Center(
//                     child: Text(
//                   'Select Semester',
//                   style: TextStyle(
//                       fontFamily: 'Manjari',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14.sp),
//                 )),
//                 icon: Icon(
//                   Icons.arrow_downward,
//                   color: Colors.black,
//                   size: 20.h,
//                 ),
//                 isExpanded: true,

//                 // The list of options
//                 items: _serviceName
//                     .map((e) => DropdownMenuItem(
//                           child: Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               e,
//                               style: TextStyle(
//                                   fontSize: 14.sp, fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           value: e,
//                         ))
//                     .toList(),

//                 // Customize the selected item
//                 selectedItemBuilder: (BuildContext context) => _serviceName
//                     .map((e) => Center(
//                           child: Text(
//                             e,
//                             style: TextStyle(
//                                 fontFamily: 'Manjari',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12.sp),
//                           ),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
