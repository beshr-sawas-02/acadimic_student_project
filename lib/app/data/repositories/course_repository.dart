// lib/app/data/repositories/course_repository.dart
import 'package:get/get.dart';
import '../providers/api_provider.dart';
import '../models/course.dart';
import '../../utils/constants.dart';

class CourseRepository {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  Future<List<Course>> getAllCourses() async {
    try {
      final response = await _apiProvider.get(ApiConstants.allCourses);

      if (response.statusCode == 200) {
        final List<dynamic> coursesData = response.data;
        return coursesData.map((data) => Course.fromJson(data)).toList();
      }
      return [];
    } catch (e) {
      print('Get all courses error: $e');
      return [];
    }
  }

  Future<List<Course>> getOpenCoursesByYear(int year) async {
    try {
      final response = await _apiProvider.get(
        '${ApiConstants.openCourses}/$year',
      );

      if (response.statusCode == 200) {
        final List<dynamic> coursesData = response.data;
        return coursesData.map((data) => Course.fromJson(data)).toList();
      }
      return [];
    } catch (e) {
      print('Get open courses error: $e');
      return [];
    }
  }

  Future<Course?> getCourseById(String id) async {
    try {
      final response = await _apiProvider.get('${ApiConstants.courseById}/$id');

      if (response.statusCode == 200) {
        return Course.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Get course by ID error: $e');
      return null;
    }
  }

  Future<List<Course>> getPrerequisites(String courseCode) async {
    try {
      final response = await _apiProvider.get(
        '${ApiConstants.course}/$courseCode/prerequisites',
      );
      print('Calling API for prerequisites of $courseCode');
      print('Raw prerequisites data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          // data is List<String> of prerequisite course codes
          List<Course> prereqs = [];
          for (var code in data) {
            if (code is String) {
              final course = await getCourseById(code);
              if (course != null) {
                prereqs.add(course);
              }
            }
          }
          return prereqs;
        }
      }
      print('Response status: ${response.statusCode}');
      return [];
    } catch (e) {
      print('Get prerequisites error: $e');
      return [];
    }
  }
}
