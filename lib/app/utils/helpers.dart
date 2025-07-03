// lib/app/utils/helpers.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'theme.dart';

class AppHelpers {
  static void showSnackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    bool isError = false,
  }) {
    Get.snackbar(
      title.tr,
      message.tr,
      snackPosition: position,
      backgroundColor: isError ? Colors.red.shade700 : AppTheme.secondaryColor,
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static void showErrorSnackBar({required String message}) {
    showSnackBar(
      title: 'error'.tr,
      message: message.tr,
      isError: true,
    );
  }

  static void showSuccessSnackBar({required String message}) {
    showSnackBar(
      title: 'success'.tr,
      message: message.tr,
      isError: false,
    );
  }

  static Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'confirm',
    String cancelText = 'cancel',
    bool isDestructive = false,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        title: Text(title.tr),
        content: Text(message.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText.tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDestructive ? Colors.red : AppTheme.secondaryColor,
            ),
            onPressed: () => Get.back(result: true),
            child: Text(confirmText.tr),
          ),
        ],
      ),
    );
  }

  static Future<void> showLoadingDialog() async {
    await Get.dialog(
      Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              color: AppTheme.secondaryColor,
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static String formatDate(DateTime? date) {
    if (date == null) return 'na'.tr;
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'na'.tr;
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String getYearText(int year) {
    switch (year) {
      case 1:
        return 'first_year'.tr;
      case 2:
        return 'second_year'.tr;
      case 3:
        return 'third_year'.tr;
      case 4:
        return 'fourth_year'.tr;
      case 5:
        return 'fifth_year'.tr;
      case 6:
        return 'of_graduates'.tr;
      case 7:
        return 'graduated'.tr;
      default:
        return 'unknown'.tr;
    }
  }

  static Color getGradeColor(double mark) {
    if (mark >= 85) return Colors.green;
    else if (mark >= 70) return Colors.blue;
    else if (mark >= 50) return Colors.orange;
    else return Colors.red;
  }

  static String getLetterGrade(double mark) {
    if (mark >= 98) return 'A+';
    else if (mark >= 95) return 'A';
    else if (mark >= 90) return 'A-';
    else if (mark >= 85) return 'B+';
    else if (mark >= 80) return 'B';
    else if (mark >= 75) return 'B-';
    else if (mark >= 70) return 'C+';
    else if (mark >= 65) return 'C';
    else if (mark >= 60) return 'C-';
    else if (mark >= 55) return 'D+';
    else if (mark >= 50) return 'D';
    else if (mark >= 0) return 'F';
    else return 'Invalid';
  }

  static double getGpaValue(double mark) {
    if (mark >= 98) return 4.0;      // A+
    else if (mark >= 95) return 3.75;  // A
    else if (mark >= 90) return 3.5;  // A-
    else if (mark >= 85) return 3.25;  // B+
    else if (mark >= 80) return 3.0;  // B
    else if (mark >= 75) return 2.75;  // B-
    else if (mark >= 70) return 2.5;  // C+
    else if (mark >= 65) return 2.25;  // C
    else if (mark >= 60) return 2.0;  // C-
    else if (mark >= 55) return 1.75;  // D+
    else if (mark >= 50) return 1.5;  // D
    else if (mark >= 0) return 0.0;   // F
    else return -1.0;
  }

  static String getMarkStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return 'normal'.tr;
      case 'deprived':
        return 'deprived'.tr;
      case 'with_draw':
        return 'withdrawn'.tr;
      case 'patchy':
        return 'incomplete'.tr;
      default:
        return 'unknown'.tr;
    }
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}