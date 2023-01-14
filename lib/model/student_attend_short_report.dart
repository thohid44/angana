// To parse this JSON data, do
//
//     final studentAttendShortReport = studentAttendShortReportFromJson(jsonString);

import 'dart:convert';



class StudentAttendShortReportModel {
    StudentAttendShortReportModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory StudentAttendShortReportModel.fromJson(Map<String, dynamic> json) => StudentAttendShortReportModel(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        message: json["Message"],
        messageCode: json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "Message": message,
        "MessageCode": messageCode,
    };
}

class Datum {
    Datum({
        this.totalStudent,
        this.presentStudent,
        this.absentStudent,
    });

    String? totalStudent;
    String? presentStudent;
    String? absentStudent;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        totalStudent: json["TotalStudent"],
        presentStudent: json["PresentStudent"],
        absentStudent: json["AbsentStudent"],
    );

    Map<String, dynamic> toJson() => {
        "TotalStudent": totalStudent,
        "PresentStudent": presentStudent,
        "AbsentStudent": absentStudent,
    };
}
