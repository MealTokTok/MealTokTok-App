import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/images/2_home/back.png'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}