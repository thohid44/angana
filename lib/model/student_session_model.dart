// To parse this JSON data, do
//
//     final studentGetSessionSelectionModel = studentGetSessionSelectionModelFromJson(jsonString);

import 'dart:convert';

List<StudentGetSessionSelectionModel> studentGetSessionSelectionModelFromJson(String str) => List<StudentGetSessionSelectionModel>.from(json.decode(str).map((x) => StudentGetSessionSelectionModel.fromJson(x)));

String studentGetSessionSelectionModelToJson(List<StudentGetSessionSelectionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentGetSessionSelectionModel {
    StudentGetSessionSelectionModel({
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

    factory StudentGetSessionSelectionModel.fromJson(Map<String, dynamic> json) => StudentGetSessionSelectionModel(
        id: json["Id"],
        name: json["Name"],
        startdate: json["Startdate"],
        enddate: json["Enddate"],
        status: statusValues.map[json["Status"]],
        message: json["Message"],
        messageCode: json["MessageCode"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Startdate": startdate,
        "Enddate": enddate,
        "Status": statusValues.reverse[status],
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
   late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
