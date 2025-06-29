// lib/app/data/repositories/course_repository.dart
import 'package:dio/dio.dart';
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

  Future<List<Course>> getOpenCoursesByYear() async {
    try {
      final response = await _apiProvider.get(
        ApiConstants.availableCourse,
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

  Future<List<String>> getPrerequisites(String courseCode) async {
    try {
      final response = await _apiProvider.get(
        '${ApiConstants.course}/$courseCode/prerequisites',
      );
      return (response.data as List)
          .map((course) => course.toString())
          .toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw e.response!.data['message'] ?? 'Failed to get prerequisites';
      } else {
        throw e.message ?? 'Failed to get prerequisites';
      }
    } catch (e) {
      throw e.toString();
    }
  }

}
