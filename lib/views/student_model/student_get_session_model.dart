// To parse this JSON data, do
//
//     final studentGetSessionModel = studentGetSessionModelFromJson(jsonString);

import 'dart:convert';

List<StudentGetSessionModel?>? studentGetSessionModelFromJson(String str) => json.decode(str) == null ? [] : List<StudentGetSessionModel?>.from(json.decode(str)!.map((x) => StudentGetSessionModel.fromJson(x)));

String studentGetSessionModelToJson(List<StudentGetSessionModel?>? data) => json.encode(data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class StudentGetSessionModel {
    StudentGetSessionModel({
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
    Status? status;
    dynamic message;
    int? messageCode;

    factory StudentGetSessionModel.fromJson(Map<String, dynamic> json) => StudentGetSessionModel(
        id: json["Id"],
        name: json["Name"],
        startdate: json["Startdate"],
        enddate: json["Enddate"],
        status: statusValues!.map[json["Status"]],
        message: json["Message"],
        messageCode: json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Startdate": startdate,
        "Enddate": enddate,
        "Status": statusValues.reverse![status],
        "Message": message,
        "MessageCode": messageCode,
    };
}

enum Status { COMPLETED }

final statusValues = EnumValues({
    "Completed": Status.COMPLETED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        reverseMap ??= map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
