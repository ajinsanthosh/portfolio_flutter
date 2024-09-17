import 'package:flutter/material.dart';
import 'package:flutter_portfolio/presentation/screens/desktop/large_screen_layout.dart';
import 'package:flutter_portfolio/presentation/screens/mobile/moble_screen_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth < 1000
          ? const MobileScreenLayout()
          : LargeScreenLayout(),
    );
  }
}
