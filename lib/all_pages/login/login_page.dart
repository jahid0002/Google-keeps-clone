import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeps/all_pages/login/login_controller.dart';
import 'package:keeps/custom_widget/custom_buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/keeps.png',
                height: size.height * 0.20,
              ),
              SizedBox(height: size.height * 0.02),
              GetBuilder<LoginController>(builder: (contxt) {
                return CustomButtons(
                    loading: controller.loading,
                    buttonName: 'Select your gmail',
                    onTap: () {
                      controller.signInWithGoogle();
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
