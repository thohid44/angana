import 'dart:convert';

import 'package:angana/model/GetCourseStudentResponse.dart';
import 'package:angana/model/student_details_model.dart';
import 'package:angana/views/teacherHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
class TodaysAttends extends StatefulWidget {
  String? coureId;
   TodaysAttends({Key? key, this.coureId}) : super(key: key);

  @override
  State<TodaysAttends> createState() => _TodaysAttendsState();
}

class _TodaysAttendsState extends State<TodaysAttends> {
  var color;
  var data;
  var result;


   
   
Future<GetCourseStudentResponse>studentFetchbyCourse() async {
    var res = await http.get(Uri.parse("http://puc.ac.bd:8098/api/Teacher/GetCourseStudent?courseId=${widget.coureId}&programId=1"));

    var jsonData = jsonDecode(res.body.toString());
   print(jsonData); 
     if(res.statusCode ==200){
      return GetCourseStudentResponse.fromJson(jsonData);
     }else{
  return GetCourseStudentResponse.fromJson(jsonData);
     }
     
  }

  void initState() {
    studentFetchbyCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeacherHome()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Text("Todays Attends"),
        centerTitle: true,
      ),
      body: FutureBuilder<GetCourseStudentResponse>(
        future: studentFetchbyCourse(),
        builder:((context, snapshot) {
       if(snapshot.hasData){
return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.data!.data!.length,
        itemBuilder: ((BuildContext context, index) {
        
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w),
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  snapshot.data!.data![index].name.toString(),
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  snapshot.data!.data![index].roll.toString(),
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 50.w,
                ),
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   if (rollList.contains(attend[index]['id'])) {
                    //     rollList.remove(attend[index]['id']);
                    //     print(rollList.remove(attend[index]['id']));
                    //     print(rollList);
                    //   } else {
                    //     rollList.add(attend[index]['id']);
                    //     print(rollList.length);
                    //     print(rollList);
                    //   }
                    // });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    alignment: Alignment.center,
                    color: rollList.contains(attend[index]['id'])
                        ? Colors.red
                        : Colors.green,
                    width: 60.w,
                    height: 50,
                    child: Text(
                      rollList.contains(attend[index]['id'])
                          ? "Absent"
                          : "Present",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          );
         
        }),
      );
       }

        return Center(child: Text("Loading...."),);
      }),),
    );
  }

  List rollList = [];
  List attend = [
    {
      "id": 3553,
      "name": "Syek Mohammed Moin Uddin",
      "roll": "1903710202003",
      "batch_name": "37",
      "status": "Absent"
    },
    {
      "id": 3553,
      "name": "Syek Mohammed Moin Uddin",
      "roll": "1903710202003",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": 3554,
      "name": "Mahi Chowdhury",
      "roll": "1903710202004",
      "batch_name": "37",
      "status": "Absent"
    },
    {
      "id": "3554",
      "name": "Mahi Chowdhury",
      "roll": "1903710202004",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3557",
      "name": "MD. Imtiaz Rahman Khan",
      "roll": "1903710202006",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3559",
      "name": "MD. Tayeb Mahmud",
      "roll": "1903710202007",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3561",
      "name": "Mohammad Irfan Khan",
      "roll": "1903710202008",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3565",
      "name": "Mossammat Nilufa Yeasmin",
      "roll": "1903710202009",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3567",
      "name": "Tonmoy Bose",
      "roll": "1903710202010",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3571",
      "name": "Niloy Barua Supta",
      "roll": "1903710202012",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3575",
      "name": "Tajin Mabud Emon",
      "roll": "1903710202016",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3576",
      "name": "MD. Tanben Faruq",
      "roll": "1903710202017",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3577",
      "name": "Nevil Chowdhury",
      "roll": "1903710202018",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3581",
      "name": "Prionkar Barua",
      "roll": "1903710202020",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3587",
      "name": "Ullash Deb Nath",
      "roll": "1903710202023",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3588",
      "name": "Hur-E-Jannath",
      "roll": "1903710202024",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3595",
      "name": "Abdus Salam",
      "roll": "1903710202029",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3600",
      "name": "Ramisa Arafath Jerin",
      "roll": "1903710202033",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3602",
      "name": "Preya Deb",
      "roll": "1903710202035",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3604",
      "name": "Mohammed Yonose",
      "roll": "1903710202037",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3605",
      "name": "Kothiza Begum Ayrin",
      "roll": "1903710202038",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3607",
      "name": "Maher Afroz",
      "roll": "1903710202040",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3608",
      "name": "Farial Robama",
      "roll": "1903710202041",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3610",
      "name": "Abdullah Al Mamun",
      "roll": "1903710202043",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3611",
      "name": "Sayeda Farhana Absar",
      "roll": "1903710202044",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3613",
      "name": "Sanjana Hannan",
      "roll": "1903710202046",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3615",
      "name": "Kashaf Hossain",
      "roll": "1903710202048",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3616",
      "name": "Tanjid Masum Emu",
      "roll": "1903710202049",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3617",
      "name": "Saira Jahan",
      "roll": "1903710202050",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3599",
      "name": "Mohammad Arif Hasan Rashid",
      "roll": "1903710202032",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3620",
      "name": "Taslima Akter Josna",
      "roll": "1903710202053",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3623",
      "name": "Ava Rahman",
      "roll": "1903710202056",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3625",
      "name": "Fahima Akter",
      "roll": "1903710202058",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3626",
      "name": "MD. Simon Alam Sakib",
      "roll": "1903710202059",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3630",
      "name": "Abdullah Al Adib",
      "roll": "1903710202060",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3631",
      "name": "Partha Shill",
      "roll": "1903710202061",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3633",
      "name": "Lamim Ahmed",
      "roll": "1903710202063",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3634",
      "name": "H.M. Tarequl Karim",
      "roll": "1903710202064",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3635",
      "name": "MD. Tanvir Chowdhury",
      "roll": "1903710202065",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3636",
      "name": "Maksudur Rahman Rafi",
      "roll": "1903710202066",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3637",
      "name": "Kazi Muntaha Ahasan",
      "roll": "1903710202067",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3639",
      "name": "Mohammad Saad Uddin Chowdhury",
      "roll": "1903710202068",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3618",
      "name": "MD. Al- Mamun",
      "roll": "1903710202051",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3582",
      "name": "R.H.M Sohag Milon",
      "roll": "1903710202021",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "3624",
      "name": "MD. Abdullah Rahman Dipu",
      "roll": "1903710202057",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "2419",
      "name": "Mominul Karim",
      "roll": "1703210201323",
      "batch_name": "32",
      "status": "Present"
    },
    {
      "id": "2036",
      "name": "Mohammad Jamshedul Islam",
      "roll": "1502910201101",
      "batch_name": "29",
      "status": "Present"
    },
    {
      "id": "3196",
      "name": "Priya Ghosh",
      "roll": "1903610201757",
      "batch_name": "36",
      "status": "Present"
    },
    {
      "id": "3274",
      "name": "Raj Dev Ullash",
      "roll": "1903610201804",
      "batch_name": "36",
      "status": "Present"
    },
    {
      "id": "3622",
      "name": "Rukshedul Islam",
      "roll": "1903710202055",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "2236",
      "name": "Moitree Das Moni",
      "roll": "1603110201229",
      "batch_name": "31",
      "status": "Present"
    },
    {
      "id": "2256",
      "name": "Muhammad Muktiar Hossen",
      "roll": "1603110201249",
      "batch_name": "31",
      "status": "Present"
    },
    {
      "id": "3614",
      "name": "Shaharin Jahan Sneha",
      "roll": "1903710202047",
      "batch_name": "37",
      "status": "Present"
    },
    {
      "id": "1749",
      "name": "Md Julhasar Sagar",
      "roll": "1502810200910",
      "batch_name": "28",
      "status": "Present"
    },
    {
      "id": "3572",
      "name": "Pritam Chowdhury",
      "roll": "1903710202013",
      "batch_name": "37",
      "status": "Present"
    }
  ];
}
