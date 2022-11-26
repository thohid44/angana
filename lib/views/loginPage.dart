import 'package:angana/views/studentHome.dart';
import 'package:angana/views/teacherHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController uId = TextEditingController();
  final TextEditingController password = TextEditingController();
  List<String> loginType = [
    'Teacher',
    "Student",
  ];
  var selected;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              child: Image.asset("assets/Picture1.png"),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 45.h,
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(13.r)),
              child: DropdownButton<String>(
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                value: selected,

                // Hide the default underline
                underline: Container(),
                hint: Center(
                    child: Text(
                  'Select Course',
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
                items: loginType
                    .map((e) => DropdownMenuItem(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          value: e,
                        ))
                    .toList(),

                // Customize the selected item
                selectedItemBuilder: (BuildContext context) => loginType
                    .map((e) => Center(
                          child: Text(
                            e,
                            style: TextStyle(
                                fontFamily: 'Manjari',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 45.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: uId,
                decoration: InputDecoration(
                    hintText: "Enter User's ID",
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
                if (selected == 'Teacher') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherHome()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentHome()));
                }
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
          ],
        ),
      ),
    );
  }
}
