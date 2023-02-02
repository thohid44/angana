import 'dart:convert';

import 'package:angana/api_url.dart';
import 'package:angana/views/Student/studentHome.dart';
import 'package:angana/views/Teacher/teacherHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

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

  studentLoginCheck() async {
    var response = await ApiUrl.userClient.post(Uri.parse(
        "http://puc.ac.bd:8098/api/Login/LoginAction?loginType=student&user=${uId.text}&pass=${password.text}"));

    var res = json.decode(response.body);
    print(res);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => StudentHome())));
      var data = res['Id'];
      var stdName = res['Name'];
      var pId = res['ProgramId'];
      var dId = res['DepartmentId'];
      print(data);
      _box.write(ApiUrl.studentId, data);
      _box.write(ApiUrl.stdName, stdName);
      _box.write(ApiUrl.pId, pId);
      _box.write(ApiUrl.dId, dId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Student Id and Password Wrong"),
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.up,
      ));
    }
  }

  final _box = GetStorage();
  teacherLoginCheck() async {
    var response = await ApiUrl.userClient.post(Uri.parse(
        "http://puc.ac.bd:8098/api/Teacher/Login?loginType=teacher&deptId=1&user=${uId.text}&pass=${password.text}"));

    var res = json.decode(response.body);
    print(res);
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => TeacherHome())));
      var tId = res['Id'];
      var deptId = res['DeptId'];
      var uname = res['UserName'];
      print(tId);
      _box.write(ApiUrl.teacherId, tId);
      _box.write(ApiUrl.TdeptId, deptId);
      _box.write(ApiUrl.userName, uname);
      print(deptId);
      print(uname);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Teacher Id and Password Wrong"),
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.up,
      ));
    }
  }

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Container(
                width: 210.w,
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: 190.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                    'Select User Type',
                    style: TextStyle(
                        fontFamily: 'Manjari',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp),
                  )),
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
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
                height: 50.h,
              ),
              Container(
                height: 45.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextFormField(
                  controller: uId,
                  
                  decoration: InputDecoration(
                      labelText: 'User ID',
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
                child:TextFormField(
   keyboardType: TextInputType.text,
   controller: password,
   obscureText: !_passwordVisible,//This will obscure text dynamically
   decoration: InputDecoration(
       labelText: 'Password',
       hintText: 'Enter your password',
        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.red,
                      ),
       // Here is key idea
       suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               _passwordVisible
               ? Icons.visibility
               : Icons.visibility_off,
               color: Theme.of(context).primaryColorDark,
               ),
            onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                   _passwordVisible = !_passwordVisible;
               });
             },
            ),
          ),
        )
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  if (selected == 'Teacher') {
                    teacherLoginCheck();
                  } else if (selected == 'Student') {
                    studentLoginCheck();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please select a user type"),
                      duration: Duration(seconds: 2),
                      dismissDirection: DismissDirection.up,
                    ));
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
      ),
    );
  }
}
