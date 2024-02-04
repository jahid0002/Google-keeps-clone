import 'package:flutter/material.dart';
import 'package:keeps/const/app_colors.dart';

// ignore: must_be_immutable
class CustomAppber extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback onTap;
  List<Widget>? actions = [];
  CustomAppber(
      {super.key,
      required this.leading,
      required this.title,
      required this.onTap,

      // ignore: avoid_init_to_null
      this.actions = null});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.06,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.contrastDarkColor.withOpacity(.7),
        ),
        child: SliverAppBar(
          floating: true,
          pinned: false,
          snap: false,
          leading: leading,
          title: title,
          actions: actions,
        ),
      ),
    );
  }
}
