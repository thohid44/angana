

import 'dart:convert';

GetCourseStudentResponse getCourseStudentResponseFromJson(String str) => GetCourseStudentResponse.fromJson(json.decode(str));

String getCourseStudentResponseToJson(GetCourseStudentResponse data) => json.encode(data.toJson());
// Teacher got stident course by course id
class GetCourseStudentResponse {
    GetCourseStudentResponse({
        this.data,
        this.message,
        this.messageCode,
    });

    List<Datum>? data;
    String? message;
    int? messageCode;

    factory GetCourseStudentResponse.fromJson(Map<String, dynamic> json) => GetCourseStudentResponse(
        data: List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
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
        this.roll,
        this.name,
        this.batchName,
        this.examtype,
    });

    int? id;
    String? roll;
    String? name;
    int? batchName;
    Examtype? examtype;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        roll: json["roll"],
        name: json["name"],
        batchName: json["batch_name"],
        examtype: examtypeValues.map[json["examtype"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "roll": roll,
        "name": name,
        "batch_name": batchName,
        "examtype": examtypeValues.reverse[examtype],
    };
}

enum Examtype { REGULAR }

final examtypeValues = EnumValues({
    "Regular": Examtype.REGULAR
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
