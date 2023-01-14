// To parse this JSON data, do
//
//     final totalClassHeld = totalClassHeldFromJson(jsonString);

import 'dart:convert';

TotalClassHeld totalClassHeldFromJson(String str) => TotalClassHeld.fromJson(json.decode(str));

String totalClassHeldToJson(TotalClassHeld data) => json.encode(data.toJson());

class TotalClassHeld {
    TotalClassHeld({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    dynamic? message;
    int? messageCode;

    factory TotalClassHeld.fromJson(Map<String, dynamic> json) => TotalClassHeld(
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
        this.id,
        this.day,
        this.date,
        this.adjClass,
        this.tblSessioncourseId,
        this.classStart,
        this.classEnd,
    });

    int? id;
    String? day;
    String? date;
    int? adjClass;
    int? tblSessioncourseId;
    String? classStart;
    String? classEnd;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        day: json["day"],
        date: json["date"],
        adjClass: json["adj_class"],
        tblSessioncourseId: json["tbl_sessioncourse_id"],
        classStart: json["class_start"],
        classEnd: json["class_end"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "date": date,
        "adj_class": adjClass,
        "tbl_sessioncourse_id": tblSessioncourseId,
        "class_start": classStart,
        "class_end": classEnd,
    };
}
