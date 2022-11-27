
import 'dart:convert';

List<TeacherRunningCourse> teacherRunningCourseFromJson(String str) => List<TeacherRunningCourse>.from(json.decode(str).map((x) => TeacherRunningCourse.fromJson(x)));


class TeacherRunningCourse {
    TeacherRunningCourse({
        this.startdate,
        this.sectionname,
        this.coursename,
        this.coursecredit,
    });

    DateTime? startdate;
    String? sectionname;
    String? coursename;
    int? coursecredit;

    factory TeacherRunningCourse.fromJson(Map<String, dynamic> json) => TeacherRunningCourse(
        startdate: DateTime.parse(json["startdate"]),
        sectionname: json["sectionname"],
        coursename: json["coursename"],
        coursecredit: json["coursecredit"],
    );

  
}
