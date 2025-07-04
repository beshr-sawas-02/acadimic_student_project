// lib/app/modules/auth/views/login_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/auth_controller.dart';
import '../../../utils/theme.dart';

class LoginView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor,
                AppTheme.primaryColor.withOpacity(0.6),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.school,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'login_app_title'.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondaryColor,
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'login_student_login'.tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controller.universityIdController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'login_university_id'.tr,
                          prefixIcon: Icon(Icons.badge),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: controller.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'login_password'.tr,
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(height: 30),
                      Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.login(),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'login_button'.tr,
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'login_contact_admin'.tr,
                        style: TextStyle(
                          color: AppTheme.secondaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'login_no_account'.tr,
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed(Routes.REGISTER),
                            child: Text(
                              'login_register'.tr,
                              style: TextStyle(
                                color: AppTheme.secondaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
