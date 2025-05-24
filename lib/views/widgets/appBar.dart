import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class appBar_Widget extends StatelessWidget implements PreferredSizeWidget {
  const appBar_Widget({super.key, required this.title});

  final String title;
  Size get preferredSize => Size.fromHeight(75.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
      centerTitle: true,
    );
  }
}
