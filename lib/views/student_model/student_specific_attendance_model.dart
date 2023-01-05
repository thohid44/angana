// To parse this JSON data, do
//
//     final studentSpicificAttendanceModel = studentSpicificAttendanceModelFromJson(jsonString);

import 'dart:convert';

StudentSpicificAttendanceModel studentSpicificAttendanceModelFromJson(String str) => StudentSpicificAttendanceModel.fromJson(json.decode(str));

String studentSpicificAttendanceModelToJson(StudentSpicificAttendanceModel data) => json.encode(data.toJson());

class StudentSpicificAttendanceModel {
    StudentSpicificAttendanceModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory StudentSpicificAttendanceModel.fromJson(Map<String, dynamic> json) => StudentSpicificAttendanceModel(
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
        this.totalClass,
        this.presentClass,
        this.absentClass,
        this.percentage,
    });

    String? totalClass;
    String? presentClass;
    String? absentClass;
    String? percentage;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        totalClass: json["totalClass"],
        presentClass: json["presentClass"],
        absentClass: json["absentClass"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "totalClass": totalClass,
        "presentClass": presentClass,
        "absentClass": absentClass,
        "percentage": percentage,
    };
}
