import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false, // يمنع ظهور زر الرجوع
      ),
      body: const Center(
        child: Text('Welcome to Home Screen!'),
      ),
    );
  }
}