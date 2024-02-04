import 'package:flutter/material.dart';
import 'package:keeps/const/app_colors.dart';

class HomeComponent extends StatelessWidget {
  final String title;
  final String note;
  final VoidCallback onTap;
  const HomeComponent(
      {super.key,
      required this.title,
      required this.note,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.backgroundDarkColor),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    note,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        )
      ],
    );
  }
}

class HomeComponent2 extends StatelessWidget {
  final String title;
  final String note;
  final VoidCallback onTap;
  const HomeComponent2(
      {super.key,
      required this.title,
      required this.note,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width / 2,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.backgroundDarkColor),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(note,
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.backgroundDarkColor,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
