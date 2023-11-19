import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(248, 255, 245, 157),
      body: SafeArea(
          child: Center(
        child: CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 0, 255, 8)),
      )),
    );
  }
}
