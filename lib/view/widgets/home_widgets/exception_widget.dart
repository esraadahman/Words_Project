import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key, required this.iconData, required this.message});
  final IconData iconData;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        size.height(220),
        Icon(
          iconData,
          color: ColorManager.white,
          size: 60,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: ColorManager.white, fontSize: 24),
        )
      ],
    );
  }
}
