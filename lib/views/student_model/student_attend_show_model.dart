// To parse this JSON data, do
//
//     final studentAttendShowModel = studentAttendShowModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';

StudentAttendShowModel studentAttendShowModelFromJson(String str) => StudentAttendShowModel.fromJson(json.decode(str));

String studentAttendShowModelToJson(StudentAttendShowModel data) => json.encode(data.toJson());

class StudentAttendShowModel {
    StudentAttendShowModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory StudentAttendShowModel.fromJson(Map<String, dynamic> json) => StudentAttendShowModel(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        message: json["Message"],
        messageCode: json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "Message": message,
        "MessageCode": messageCode,
    };

  map(Container Function(dynamic e) param0) {}
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
