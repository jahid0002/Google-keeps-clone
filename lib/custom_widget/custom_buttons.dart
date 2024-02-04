import 'package:flutter/material.dart';
import 'package:keeps/const/app_colors.dart';

class CustomButtons extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  final bool loading;
  const CustomButtons(
      {super.key,
      required this.buttonName,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: loading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.06,
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.backgroundDarkColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                color: AppColors.contrastDarkColor,
              ))
            : Text(
                buttonName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
      ),
    );
  }
}
