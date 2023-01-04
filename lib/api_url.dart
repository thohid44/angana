import 'package:http/http.dart' as http;

class ApiUrl {
  static final token = '302|kqsrC7vOkljIX68usiZiGV5zCDMkjkyovsjZuABv';

  static final userClient = http.Client();

  static final teacherId = "TeacherId"; 
  static final studentId = "StudentId"; 
  static const baseUrl = 'demo.webpointbd.com';
  static const logInUrl = 'teacher-login';
}
