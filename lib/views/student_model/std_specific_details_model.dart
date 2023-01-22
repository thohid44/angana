// To parse this JSON data, do
//
//     final studentSpecificDatailsModel = studentSpecificDatailsModelFromJson(jsonString);

import 'dart:convert';

StudentSpecificDatailsModel studentSpecificDatailsModelFromJson(String str) => StudentSpecificDatailsModel.fromJson(json.decode(str));

String studentSpecificDatailsModelToJson(StudentSpecificDatailsModel data) => json.encode(data.toJson());

class StudentSpecificDatailsModel {
    StudentSpecificDatailsModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory StudentSpecificDatailsModel.fromJson(Map<String, dynamic> json) => StudentSpecificDatailsModel(
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
        this.date,
        this.day,
        this.classStart,
        this.classEnd,
        this.adjustmentClass,
        this.status,
    });

    String? date;
    String? day;
    String? classStart;
    String? classEnd;
    String? adjustmentClass;
    String? status;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        day: json["day"],
        classStart: json["class_start"],
        classEnd: json["class_end"],
        adjustmentClass: json["adjustmentClass"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "day": day,
        "class_start": classStart,
        "class_end": classEnd,
        "adjustmentClass": adjustmentClass,
        "status": status,
    };
}
