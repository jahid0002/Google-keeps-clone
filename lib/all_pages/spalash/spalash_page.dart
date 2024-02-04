import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeps/all_pages/spalash/spalash_controller.dart';
import 'package:keeps/const/app_colors.dart';

class SpalashPage extends StatelessWidget {
  const SpalashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SpalashController());
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              Image.asset(
                'assets/keeps.png',
                height: size.height * 0.13,
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Text(
                'Keeps Note',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryTextColor.withOpacity(.7)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
