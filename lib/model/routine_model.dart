// To parse this JSON data, do
//
//     final routineModel = routineModelFromJson(jsonString);

import 'dart:convert';

RoutineModel routineModelFromJson(String str) => RoutineModel.fromJson(json.decode(str));

String routineModelToJson(RoutineModel data) => json.encode(data.toJson());

class RoutineModel {
    RoutineModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory RoutineModel.fromJson(Map<String, dynamic> json) => RoutineModel(
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
        this.dayname,
        this.classTime,
        this.classStart,
        this.classEnd,
        this.adjClass,
    });

    int? id;
    String? dayname;
    String? classTime;
    String? classStart;
    String? classEnd;
    int? adjClass;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dayname: json["dayname"],
        classTime: json["class_time"],
        classStart: json["class_start"],
        classEnd: json["class_end"],
        adjClass: json["adj_class"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dayname": dayname,
        "class_time": classTime,
        "class_start": classStart,
        "class_end": classEnd,
        "adj_class": adjClass,
    };
}
