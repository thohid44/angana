// To parse this JSON data, do
//
//     final studentDetailsModel = studentDetailsModelFromJson(jsonString);

import 'dart:convert';

List<StudentDetailsModel> studentDetailsModelFromJson(String str) =>
    List<StudentDetailsModel>.from(
        json.decode(str).map((x) => StudentDetailsModel.fromJson(x)));

String studentDetailsModelToJson(List<StudentDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentDetailsModel {
  StudentDetailsModel({
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

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) =>
      StudentDetailsModel(
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
