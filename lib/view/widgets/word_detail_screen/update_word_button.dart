import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';

class UpdateWordButton extends StatelessWidget {
  UpdateWordButton({super.key, required this.color, required this.onTap});
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: const Icon(
          Icons.add,
          color: ColorManager.black,
        ),
      ),
    );
  }
}
