// To parse this JSON data, do
//
//     final studentCourseModel = studentCourseModelFromJson(jsonString);

import 'dart:convert';

StudentCourseModel studentCourseModelFromJson(String str) => StudentCourseModel.fromJson(json.decode(str));

String studentCourseModelToJson(StudentCourseModel data) => json.encode(data.toJson());
enum Status { ABSENT, PRESENT }
class StudentCourseModel {
    StudentCourseModel({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory StudentCourseModel.fromJson(Map<String, dynamic> json) => StudentCourseModel(
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
    Status? status;

    factory Datum.fromJson(Map<String?, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        roll: json["roll"],
        batchName: json["batch_name"],
        status: statusValues.map[json["status"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roll": roll,
        "batch_name": batchName,
        // "status": statusValues.reverse[status],
    };
}



final statusValues = EnumValues({
    "Absent": Status.ABSENT,
    "Present": Status.PRESENT
});

class EnumValues<T> {
    Map<String, T> map;
    // Map<T, String>? reverseMap;

    EnumValues(this.map, );

    // Map<T, String>? get reverse {
    //     if (reverseMap == null) {
    //         reverseMap = map.map((k, v) => new MapEntry(v, k));
    //     }
    //     return reverseMap;
    // }
}
