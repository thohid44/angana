// To parse this JSON data, do
//
//     final studentSessionCourseResponse = studentSessionCourseResponseFromJson(jsonString);

import 'dart:convert';

List<StudentSessionCourseResponse> studentSessionCourseResponseFromJson(
        String str) =>
    List<StudentSessionCourseResponse>.from(
        json.decode(str).map((x) => StudentSessionCourseResponse.fromJson(x)));

String studentSessionCourseResponseToJson(
        List<StudentSessionCourseResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentSessionCourseResponse {
  StudentSessionCourseResponse({
    this.id,
    this.course,
    this.courseCode,
    this.section,
    this.credit,
    this.status,
    this.examtype,
    this.courseFee,
    this.examFee,
    this.message,
    this.messageCode,
  });

  int? id;
  String? course;
  String? courseCode;
  String? section;
  String? credit;
  String? status;
  String? examtype;
  dynamic? courseFee;
  dynamic? examFee;
  dynamic? message;
  int? messageCode;

  factory StudentSessionCourseResponse.fromJson(Map<String, dynamic> json) =>
      StudentSessionCourseResponse(
        id: json["Id"],
        course: json["Course"],
        courseCode: json["CourseCode"],
        section: json["Section"],
        credit: json["Credit"],
        status: json["Status"],
        examtype: json["Examtype"],
        courseFee: json["CourseFee"],
        examFee: json["ExamFee"],
        message: json["Message"],
        messageCode: json["MessageCode"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Course": course,
        "CourseCode": courseCode,
        "Section": section,
        "Credit": credit,
        "Status": status,
        "Examtype": examtype,
        "CourseFee": courseFee,
        "ExamFee": examFee,
        "Message": message,
        "MessageCode": messageCode,
      };
}
