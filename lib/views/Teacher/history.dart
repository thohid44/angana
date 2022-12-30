import 'package:angana/views/Teacher/student_specific_data.dart';
import 'package:angana/views/Teacher/teacher_total_cls_held_previous.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Select Option"), value: "Select Option"),
      const DropdownMenuItem(
          child: Text("Total Class Held Privious"),
          value: "Total Class Held Privious"),
      const DropdownMenuItem(
          child: Text("Specific Student Data"), value: "Specific Student Data"),
    ];
    return menuItems;
  }

  String selectedValue = 'Select Option';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("History"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              height: 45.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.w, color: Colors.grey)),
              child: DropdownButton(
                  underline: SizedBox(),
                  value: selectedValue,
                  style: TextStyle(color: Colors.black, fontSize: 17.sp),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                      if (selectedValue == 'Total Class Held Privious') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TeacherTotalClsHelpPrevious()));
                      } else if (selectedValue == 'Specific Student Data') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentSpecificData()));
                      }
                    });
                  },
                  items: dropdownItems)),
        ],
      ),
    );
  }
}
