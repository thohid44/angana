import 'package:angana/views/Teacher/teacherHome.dart';
import 'package:angana/views/teacherReg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  final TextEditingController stdId = TextEditingController();
  final TextEditingController password = TextEditingController();

  teacherLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 15.h,
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
              controller: stdId,
              decoration: InputDecoration(
                  hintText: "Enter Teacher's ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r)),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.red,
                  )),
            ),
          ),
          SizedBox(
            height: 25.h,
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
          GestureDetector(
            onTap: () {
              print("password");
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Text(
                "Forget password",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => TeacherHome()));
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
                "Login",
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
                  MaterialPageRoute(builder: (context) => TeacherReg()));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Text(
                "Have you no account?",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
