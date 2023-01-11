import 'package:http/http.dart' as http;

class ApiUrl {
  static final token = '302|kqsrC7vOkljIX68usiZiGV5zCDMkjkyovsjZuABv';

  static final userClient = http.Client();

  static final teacherId = "TeacherId"; 
  static final TdeptId = "DepartmentId"; 
  static final userName = "UserName"; 
  static final stdSessionId = 'STDSessionId';

  static final studentId = "StudentId"; 
  static final stdName="StdName";
  static final pId ="ProgramId";
  static final dId = "DepartmentId"; 
  static const baseUrl = 'demo.webpointbd.com';
  static const logInUrl = 'teacher-login';
}
