import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodaysAttends extends StatefulWidget {
  const TodaysAttends({Key? key}) : super(key: key);

  @override
  State<TodaysAttends> createState() => _TodaysAttendsState();
}

class _TodaysAttendsState extends State<TodaysAttends> {
  var color;
  var data;
  var result;
  List student = [
    {
      'id': '00100201',
      'name': 'Abdul Khader',
    },
    {
      'id': '00100202',
      'name': 'Abdul Khader',
    },
    {
      'id': '00100204',
      'name': 'Abdul Khader',
    },
    {
      'id': '00100205',
      'name': 'Abdul Khader',
    },
    {
      'id': '00100206',
      'name': 'Abdul Khader',
    },
    {
      'id': '00100207',
      'name': 'Abdul Khader',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todays Attends"),
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 70.w,
                  height: 50.h,
                  child: Text(
                    "Student ID",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.w,
                  height: 50.h,
                  child: Text(
                    "Student Name",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 100.w,
                  height: 50.h,
                  child: Text(
                    "Action",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: student.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            student[index]['id'],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          Text(
                            student[index]['name'],
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              var id = student[index]['id'];
                              print(id);
                              setState(() {
                                color = id;
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 30.h,
                                width: 60.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.r),
                                    color: color != student[index]['id']
                                        ? Colors.blue
                                        : Colors.red),
                                child: Text(
                                  color != student[index]['id']
                                      ? "Present"
                                      : "Absent",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    );
                  })))
        ],
      ),
    );
  }
}
