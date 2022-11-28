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
  List<Attend> student = [
   Attend("121", "Angana", false),
   Attend("122", "Angana", false),
   Attend("123", "Angana", false)
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
                  child:const Text(
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
                  child:const Text(
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
            height: 15.h,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: student.length,
                  itemBuilder: ((BuildContext context, int index) {
                    return AttendItem(student[index].id.toString() , student[index].name.toString(), student[index].selected,
                   index
                    );
                  })))
        ],
      ),
    );
  }
  Widget AttendItem( id,  name,  selected,  index){ 
 return ListTile(); 

  }
}

class Attend{
String? id;
String? name; 
bool? selected;  
Attend(this.id, 
this.name, this.selected
);
}