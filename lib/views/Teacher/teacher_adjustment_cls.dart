import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TeacherAjustmentClass extends StatefulWidget {
  String? sessionCourseId;

  TeacherAjustmentClass({super.key, this.sessionCourseId});

  @override
  State<TeacherAjustmentClass> createState() => _TeacherAjustmentClassState();
}

class _TeacherAjustmentClassState extends State<TeacherAjustmentClass> {
  final TextEditingController date = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  var deptId;
  String? entryBy;
  final _box = GetStorage();

  void initState() {
    deptId = _box.read(ApiUrl.TdeptId);
    entryBy = _box.read(ApiUrl.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Adjustment Class"),
      ),
      body: Column(
      
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
            child: TextFormField(
              controller: date,
              decoration: InputDecoration(
                  hintText: "MM/DD/YYYY", border: OutlineInputBorder()),
            ),
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
            child: TextFormField(
              controller: day,
              decoration: InputDecoration(
                  hintText: "Day", border: OutlineInputBorder()),
            ),
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
            child: TextFormField(
              controller: startTime,
              decoration: InputDecoration(
                  hintText: "Start Time", border: OutlineInputBorder()),
            ),
          ),
          Container(
            height: 50.h,
            margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
            child: TextFormField(
              controller: endTime,
              decoration: InputDecoration(
                  hintText: "end Time", border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              saveAdjustmentClass();
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              height: 50.h,
              width: 210.w,
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                "Save Adjustment Class",
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

  saveAdjustmentClass() async {
   
    var response = await http.post(
      Uri.parse(
          "http://puc.ac.bd:8098/api/StudentAttendance/SetAdjClass?sessionCourseId=${widget.sessionCourseId}&date=12/10/22&day=${day.text.toString()}&startTime=${startTime.text.toString()}&endTime=${endTime.text.toString()}&deptId=$deptId&entryBy=$entryBy"),
    );

    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(res);
    }
  }
}
