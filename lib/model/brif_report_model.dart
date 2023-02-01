// To parse this JSON data, do
//
//     final brifReportModel = brifReportModelFromJson(jsonString);

import 'dart:convert';

BrifReportModel brifReportModelFromJson(String str) => BrifReportModel.fromJson(json.decode(str));

String brifReportModelToJson(BrifReportModel data) => json.encode(data.toJson());

class BrifReportModel {
    BrifReportModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory BrifReportModel.fromJson(Map<String, dynamic> json) => BrifReportModel(
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
        this.name,
        this.roll,
        this.batchName,
        this.status,
    });

    String? id;
    String? name;
    String? roll;
    String? batchName;
    String? status;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        roll: json["roll"],
        batchName: json["batch_name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roll": roll,
        "batch_name": batchName,
        "status": status,
    };
}
