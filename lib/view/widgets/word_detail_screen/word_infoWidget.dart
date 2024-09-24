import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/Style/color_manager.dart';
import 'package:flutter_application_1/view/Style/size.dart';

class WordInfowidget extends StatelessWidget {
  WordInfowidget(
      {super.key,
      required this.color,
      required this.text,
      required this.isArabic,
      this.onPressed});
  final Color color;
  final String text;
  final bool isArabic;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          // is arabic or english
          CircleAvatar(
            radius: 25,
            backgroundColor: ColorManager.black,
            child: Text(
              isArabic ? "ar" : "en",
              style: TextStyle(color: color),
            ),
          ),

          // word text
          size.width(10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  color: ColorManager.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // size.width(180),
          // check if word or (example || simlar)
          if (onPressed != null)
            IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.delete,
                color: ColorManager.black,
              ),
            )
        ],
      ),
    );
  }
}
