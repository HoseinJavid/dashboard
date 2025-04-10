import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String phone;
  const DashboardScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('داشبورد')),
      body: Center(
        child: Text('شماره وارد شده: $phone'),
      ),
    );
  }
}
