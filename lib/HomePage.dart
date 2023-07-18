// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sde_007_assignment/MobileHome.dart';
import 'package:sde_007_assignment/TabletHome.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              return const TabletHomePage();
            } else {
              return const MobileHomePage();
            }
          },
        );
  }
}