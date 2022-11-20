import 'dart:convert';

import 'package:angana/model/student_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {

void initState(){
  fetchstudentCourseModel();
  super.initState(); 
}
  Future<List<StudentCourseModel>> fetchstudentCourseModel() async{
    final  jsonData =  await rootBundle.rootBundle.loadString('assets/student_course.json'); 

    final list = json.decode(jsonData.toString()) as List<dynamic>; 
    
    return list.map((e) => StudentCourseModel.fromJson(e)).toList();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Home"),),
      body: FutureBuilder(
         future: fetchstudentCourseModel(), 
         builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"));
          }else if(snapshot.hasData){
              var items = snapshot.data as List<StudentCourseModel>; 
       return ListView.builder(
      itemCount: 5,
   itemBuilder:(context,index){
    return ListTile(title: Text(items[index].course.toString()));
   },
       );
          }else{
            return Center(child:CircularProgressIndicator()); 
          }
         },

      ), 
    );
  }
}
