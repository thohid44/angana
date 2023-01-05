
import 'package:angana/views/Student/studentHome.dart';
import 'package:angana/views/student_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final TextEditingController stdId = TextEditingController();
  final TextEditingController password = TextEditingController();
    List data = [
      '123', '12345'
    ];
    studentLoginCheck(){
      if(data.contains(stdId.text.toString()) && data.contains(stdId.text.toString()) ){
        print(stdId.text);
       Navigator.push(context, MaterialPageRoute(builder:(_)=>StudentHome()));
      } else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User and Password Wrong"), 
        
        duration: Duration(seconds: 2), 
        dismissDirection: DismissDirection.up,
        ));
      }
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Container(
            child: Image.asset("assets/Picture1.png"),
          ),
          SizedBox(
            height: 40.h,
          ),
          Container(
            height: 45.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: stdId,
              decoration: InputDecoration(
                  hintText: "Enter student ID",
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
             studentLoginCheck();
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
                  MaterialPageRoute(builder: (context) => StudentReg()));
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

  List stdList = [
    {
    "Id": 2575,
    "DepartmentId": 1,
    "ProgramId": 1,
    "Name": "Tasnim Sultana",
    "Roll": "1703310201452",
    "Status": null,
    "Salt": 0,
    "Password": "12345",
    "DepartmentName": null,
    "CGPA": null,
    "Credit": 0.0,
    "TotalCredit": 0.0,
    "Last_Result_Update": null,
    "ProgramName": null,
    "Batch": "33",
    "Url": "http://192.168.2.10/studenteng/student_image/1703310201452-2575.jpg",
    "Phone": "01532450444",
    "LoginType": "student",
    "Email": "",
    "Address": "Chandgoan R/A,Block-B,Road no-7,House no-133,Chittagong",
    "Advisor": "Anik Sen",
    "Message": "Successfully Logged in",
    "MessageCode": 200
},
{
    "Id": 2576,
    "DepartmentId": 1,
    "ProgramId": 1,
    "Name": "Angana Barua",
    "Roll": "1703310201453",
    "Status": null,
    "Salt": 0,
    "Password": "12345",
    "DepartmentName": null,
    "CGPA": null,
    "Credit": 0.0,
    "TotalCredit": 0.0,
    "Last_Result_Update": null,
    "ProgramName": null,
    "Batch": "33",
    "Url": "http://192.168.2.10/studenteng/student_image/1703310201452-2575.jpg",
    "Phone": "01532450444",
    "LoginType": "student",
    "Email": "",
    "Address": "Chandgoan R/A,Block-B,Road no-7,House no-133,Chittagong",
    "Advisor": "Anik Sen",
    "Message": "Successfully Logged in",
    "MessageCode": 200
}

];
}
