import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/mark_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/mark.dart';
import '../../../data/providers/storage_provider.dart';

class MarkController extends GetxController {
  final MarkRepository _markRepository = Get.find<MarkRepository>();
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final StorageProvider _storageProvider = Get.find<StorageProvider>();
  RxInt selectedYear = 1.obs;
  RxInt selectedSemester = 1.obs;

  final RxBool isLoading = false.obs;
  final RxList<Mark> myMarks = <Mark>[].obs;
  final RxMap<String, dynamic> semesterGPA = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> cumulativeGPA = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyMarks();
  }

  Future<void> fetchMyMarks() async {
    isLoading.value = true;

    try {
      final marks = await _markRepository.getMyMarks();
      myMarks.assignAll(marks);

    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_load_marks'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSemesterGPA(int year, int semester) async {
    isLoading.value = true;

    try {
      final student = _storageProvider.getUser();
      if (student != null && student.id != null) {
        final gpaData = await _authRepository.getSemesterGPA(student.id!, year, semester);
        if (gpaData != null) {
          semesterGPA.value = gpaData;
        }
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_load_semester_gpa'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCumulativeGPA() async {
    isLoading.value = true;

    try {
      final student = _storageProvider.getUser();
      if (student != null && student.id != null) {
        final gpaData = await _authRepository.getCumulativeGPA(student.id!);
        if (gpaData != null) {
          cumulativeGPA.value = gpaData;
        }
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_load_cumulative_gpa'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }


  String getLetterGrade(double mark) {
    if (mark < 50) {
      return "F";
    } else if (mark < 55) {
      return "D";
    } else if (mark < 60) {
      return "D+";
    } else if (mark < 65) {
      return "C-";
    } else if (mark < 70) {
      return "C";
    } else if (mark < 75) {
      return "C+";
    } else if (mark < 80) {
      return "B-";
    } else if (mark < 85) {
      return "B";
    } else if (mark < 90) {
      return "B+";
    } else if (mark < 95) {
      return "A-";
    } else if (mark < 98) {
      return "A";
    } else if (mark <= 100) {
      return "A+";
    } else {
      return "Invalid";
    }
  }


  double getGradePoint(double mark) {
    if (mark < 50) {
      return 0.0;
    } else if (mark < 55) {
      return 1.5;
    } else if (mark < 60) {
      return 1.75;
    } else if (mark < 65) {
      return 2.0;
    } else if (mark < 70) {
      return 2.25;
    } else if (mark < 75) {
      return 2.5;
    } else if (mark < 80) {
      return 2.75;
    } else if (mark < 85) {
      return 3.0;
    } else if (mark < 90) {
      return 3.25;
    } else if (mark < 95) {
      return 3.5;
    } else if (mark < 98) {
      return 3.75;
    } else if (mark <= 100) {
      return 4.0;
    } else {
      return -1.0; // Invalid mark
    }
  }


  Color getGradeColor(double mark) {
    final point = getGradePoint(mark);
    if (point >= 3.5) {
      return Colors.green;
    } else if (point >= 2.5) {
      return Colors.blue;
    } else if (point >= 2.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
