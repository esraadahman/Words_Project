import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';

class Donebutton extends StatelessWidget {
  const Donebutton({super.key, required this.colorcode, required this.onTap});
  final int colorcode;
  final VoidCallback onTap;
  // final Function onTap2;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(
                  color: Color(colorcode),
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
