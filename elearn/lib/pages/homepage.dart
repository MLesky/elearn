import 'package:flutter/material.dart';
import 'package:elearn/data/wi_widgets.dart';

/// HomeScreen / Dashboard
/// Body is wrapped around a safe area to uhmmm...
/// well..., give a it a safe area
///
/// A list of random courses will be displayed
/// It uses the [CourseList] class
/// Check its implementation in the [wi_widgets.dart]

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TopToolBar(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Some Text"),
                background: Image.asset(
                  'assets/images/campus-1.jpg',
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.colorBurn,
                ),
              ),
            ),
            const SliverFillRemaining(child: CourseList()),
          ],
        ),
      ),
    );
  }
}
