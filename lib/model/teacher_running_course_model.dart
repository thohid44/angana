// To parse this JSON data, do
//
//     final teacherRunningCourseResponse = teacherRunningCourseResponseFromJson(jsonString);

import 'dart:convert';

TeacherRunningCourseResponse teacherRunningCourseResponseFromJson(String str) => TeacherRunningCourseResponse.fromJson(json.decode(str));

String teacherRunningCourseResponseToJson(TeacherRunningCourseResponse data) => json.encode(data.toJson());

class TeacherRunningCourseResponse {
    TeacherRunningCourseResponse({
        this.data,
        this.message,
        this.messageCode,
    });

    List<TeaRuncourse>? data;
    String? message;
    int? messageCode;

    factory TeacherRunningCourseResponse.fromJson(Map<String, dynamic> json) => TeacherRunningCourseResponse(
        data: List<TeaRuncourse>.from(json["Data"].map((x) => TeaRuncourse.fromJson(x))),
        message: json["Message"],
        messageCode: json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "Message": message,
        "MessageCode": messageCode,
    };
}

class TeaRuncourse {
    TeaRuncourse({
        this.startdate,
        this.sectionname,
        this.sessionname,
        this.department,
        this.expr1,
        this.id,
        this.semester,
        this.coursecode,
        this.coursename,
        this.coursecredit,
    });

    DateTime? startdate;
    String? sectionname;
    String? sessionname;
    String? department;
    String? expr1;
    int? id;
    String? semester;
    String? coursecode;
    String? coursename;
    dynamic? coursecredit;

    factory TeaRuncourse.fromJson(Map<String, dynamic> json) => TeaRuncourse(
        startdate: DateTime.parse(json["startdate"]),
        sectionname: json["sectionname"],
        sessionname: json["sessionname"],
        department: json["department"],
        expr1: json["Expr1"],
        id: json["id"],
        semester: json["semester"],
        coursecode: json["coursecode"],
        coursename: json["coursename"],
        coursecredit: json["coursecredit"],
    );

    Map<String, dynamic> toJson() => {
        "startdate": startdate!.toIso8601String(),
        "sectionname": sectionname,
        "sessionname": sessionname,
        "department": department,
        "Expr1": expr1,
        "id": id,
        "semester": semester,
        "coursecode": coursecode,
        "coursename": coursename,
        "coursecredit": coursecredit,
    };
}
