// To parse this JSON data, do
//
//     final studentCourseModel = studentCourseModelFromJson(jsonString);

import 'dart:convert';

List<StudentCourseResponse> studentCourseModelFromJson(String str) => List<StudentCourseResponse>.from(json.decode(str).map((x) => StudentCourseResponse.fromJson(x)));

String studentCourseModelToJson(List<StudentCourseResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentCourseResponse {
    StudentCourseResponse({
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
    int? courseFee;
    int? examFee;
    dynamic message;
    int? messageCode;

    factory StudentCourseResponse.fromJson(Map<String, dynamic> json) => StudentCourseResponse(
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
