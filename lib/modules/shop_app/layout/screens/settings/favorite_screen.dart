import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'setting_screen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}