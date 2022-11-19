

import 'dart:convert';

List<StudentCourseModel> studentCourseModelFromJson(String str) => List<StudentCourseModel>.from(json.decode(str).map((x) => StudentCourseModel.fromJson(x)));

String studentCourseModelToJson(List<StudentCourseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentCourseModel {
    StudentCourseModel({
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
    dynamic courseFee;
    dynamic examFee;
    dynamic message;
    int? messageCode;

    factory StudentCourseModel.fromJson(Map<String, dynamic> json) => StudentCourseModel(
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
