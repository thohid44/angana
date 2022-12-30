import 'package:angana/views/Teacher/teacherLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherReg extends StatefulWidget {
  const TeacherReg({Key? key}) : super(key: key);

  @override
  State<TeacherReg> createState() => _TeacherRegState();
}

class _TeacherRegState extends State<TeacherReg> {
  final TextEditingController teacherId = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController department = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            child: Image.asset("assets/Picture1.png"),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 45.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: teacherId,
              decoration: InputDecoration(
                  hintText: "Enter Teacher ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.red,
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 45.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: teacherId,
              decoration: InputDecoration(
                  hintText: "Enter Department ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.red,
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 45.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                  hintText: "Enter password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r)),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.red,
                  )),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 60.w),
              alignment: Alignment.center,
              width: 150.w,
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: Color(0xffFE8178)),
              child: Text(
                "Register",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeacherLogin()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Text(
                "Already Registered? LogIn",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
