// To parse this JSON data, do
//
//     final teacherLoginModel = teacherLoginModelFromJson(jsonString);

import 'dart:convert';

List<TeacherLoginModel> teacherLoginModelFromJson(String str) =>
    List<TeacherLoginModel>.from(
        json.decode(str).map((x) => TeacherLoginModel.fromJson(x)));

String teacherLoginModelToJson(List<TeacherLoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherLoginModel {
  TeacherLoginModel({
    this.id,
    this.departmentId,
    this.programId,
    this.name,
    this.roll,
    this.status,
    this.salt,
    this.password,
    this.departmentName,
    this.cgpa,
    this.credit,
    this.totalCredit,
    this.lastResultUpdate,
    this.programName,
    this.batch,
    this.url,
    this.phone,
    this.loginType,
    this.email,
    this.address,
    this.advisor,
    this.message,
    this.messageCode,
  });

  int? id;
  int? departmentId;
  int? programId;
  dynamic name;
  dynamic roll;
  dynamic status;
  int? salt;
  dynamic password;
  dynamic departmentName;
  dynamic cgpa;
  int? credit;
  int? totalCredit;
  dynamic lastResultUpdate;
  dynamic programName;
  dynamic batch;
  dynamic url;
  dynamic phone;
  dynamic loginType;
  dynamic email;
  dynamic address;
  dynamic advisor;
  String? message;
  int? messageCode;

  factory TeacherLoginModel.fromJson(Map<String, dynamic> json) =>
      TeacherLoginModel(
        id: json["Id"],
        departmentId: json["DepartmentId"],
        programId: json["ProgramId"],
        name: json["Name"],
        roll: json["Roll"],
        status: json["Status"],
        salt: json["Salt"],
        password: json["Password"],
        departmentName: json["DepartmentName"],
        cgpa: json["CGPA"],
        credit: json["Credit"],
        totalCredit: json["TotalCredit"],
        lastResultUpdate: json["Last_Result_Update"],
        programName: json["ProgramName"],
        batch: json["Batch"],
        url: json["Url"],
        phone: json["Phone"],
        loginType: json["LoginType"],
        email: json["Email"],
        address: json["Address"],
        advisor: json["Advisor"],
        message: json["Message"],
        messageCode: json["MessageCode"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "DepartmentId": departmentId,
        "ProgramId": programId,
        "Name": name,
        "Roll": roll,
        "Status": status,
        "Salt": salt,
        "Password": password,
        "DepartmentName": departmentName,
        "CGPA": cgpa,
        "Credit": credit,
        "TotalCredit": totalCredit,
        "Last_Result_Update": lastResultUpdate,
        "ProgramName": programName,
        "Batch": batch,
        "Url": url,
        "Phone": phone,
        "LoginType": loginType,
        "Email": email,
        "Address": address,
        "Advisor": advisor,
        "Message": message,
        "MessageCode": messageCode,
      };
}
