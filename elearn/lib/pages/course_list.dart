import 'package:flutter/material.dart';

import '../data/wi_widgets.dart';

/// #CourseList Screen
///
/// Displays a list of the users enrolled courses
/// It is accessible through the bottom navigation bar (My Courses)
/// [CourseList] will take the students ID as a parameter and use it
/// to display a list of the students enrolled or finished courses
///
/// See implementation of [CourseList] in the [wi_widget.dart] file
/// or just ctrl click of [CourseList]

class UserCoursePage extends StatefulWidget {
  const UserCoursePage({super.key});

  @override
  State<UserCoursePage> createState() => _UserCoursePageState();
}

class _UserCoursePageState extends State<UserCoursePage> {
  final title = 'E-learn';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TopToolBar(context),
      body: const CourseList(/* users courses */),
    );
  }
}
