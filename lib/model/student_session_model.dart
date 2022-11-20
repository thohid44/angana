// To parse this JSON data, do
//
//     final studentSessionModel = studentSessionModelFromJson(jsonString);

import 'dart:convert';

List<StudentSessionModel> studentSessionModelFromJson(String str) => List<StudentSessionModel>.from(json.decode(str).map((x) => StudentSessionModel.fromJson(x)));

String studentSessionModelToJson(List<StudentSessionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentSessionModel {
    StudentSessionModel({
        this.id,
        this.name,
        this.startdate,
        this.enddate,
        this.status,
        this.message,
        this.messageCode,
    });

    int? id;
    String? name;
    String? startdate;
    String? enddate;
    String? status;
    dynamic message;
    int? messageCode;

    factory StudentSessionModel.fromJson(Map<String, dynamic> json) => StudentSessionModel(
        id: json["Id"],
        name: json["Name"],
        startdate: json["Startdate"],
        enddate: json["Enddate"],
        status: json["Status"],
        message: json["Message"],
        messageCode: json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Startdate": startdate,
        "Enddate": enddate,
        "Status": status,
        "Message": message,
        "MessageCode": messageCode,
    };
}
