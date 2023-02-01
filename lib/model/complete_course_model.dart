// To parse this JSON data, do
//
//     final completedCourseModel = completedCourseModelFromJson(jsonString);

import 'dart:convert';

CompletedCourseModel completedCourseModelFromJson(String str) =>
    CompletedCourseModel.fromJson(json.decode(str));

String completedCourseModelToJson(CompletedCourseModel data) =>
    json.encode(data.toJson());

class CompletedCourseModel {
  CompletedCourseModel({
    this.data,
    this.message,
    this.messageCode,
  });

  List<Datum>? data;
  String? message;
  int? messageCode;

  factory CompletedCourseModel.fromJson(Map<String, dynamic> json) =>
      CompletedCourseModel(
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
    this.sessionname,
    this.startdate,
    this.enddate,
    this.status,
  });

  int? id;
  String? sessionname;
  String? startdate;
  String? enddate;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sessionname: json["sessionname"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sessionname": sessionname,
        "startdate": startdate,
        "enddate": enddate,
        "status": status,
      };
}
